#!/usr/bin/env bash
# Verify the form's redirect contract in the repo's config files.
#
# index.html's contact form posts to action="/thank-you", which is NOT a
# file: it only resolves because a 200-rewrite maps it to /thank-you.html.
# That rule lives in netlify.toml and _redirects. Delete or mistype it and
# the form submits into a 404 -- invisible on a lead-capture site, because a
# broken form looks exactly like a quiet week.
#
# Exit 0 = contract intact, exit 1 = contract broken.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INDEX="${REPO_ROOT}/index.html"
NETLIFY_TOML="${REPO_ROOT}/netlify.toml"
REDIRECTS="${REPO_ROOT}/_redirects"

failures=0

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  failures=$((failures + 1))
}

pass() {
  printf 'ok: %s\n' "$1"
}

# --- The form itself ---

if [[ ! -f "${INDEX}" ]]; then
  fail "index.html not found at ${INDEX}"
  printf '\n%d check(s) failed.\n' "${failures}" >&2
  exit 1
fi

form_block="$(sed -n '/<form[^>]*class="contact-form"/,/<\/form>/p' "${INDEX}")"

if [[ -z "${form_block}" ]]; then
  fail 'no contact form block found in index.html'
  printf '\n%d check(s) failed.\n' "${failures}" >&2
  exit 1
fi
pass 'contact form block present'

form_open_tag="$(printf '%s' "${form_block}" | sed -n '1p')"

if [[ "${form_open_tag}" == *'data-netlify="true"'* ]]; then
  pass 'form carries data-netlify="true"'
else
  fail 'form is missing data-netlify="true" (Netlify will not capture submissions)'
fi

if [[ "${form_open_tag}" == *'method="POST"'* ]]; then
  pass 'form declares method="POST"'
else
  fail 'form is missing method="POST"'
fi

# The hidden form-name input must agree with the form's name attribute, or
# Netlify routes the submission to a form that does not exist.
form_name="$(printf '%s' "${form_open_tag}" \
  | sed -n 's/.*<form[^>]*[^-]name="\([^"]*\)".*/\1/p')"

if [[ -z "${form_name}" ]]; then
  fail 'form has no name attribute'
else
  pass "form name is \"${form_name}\""

  if printf '%s' "${form_block}" \
    | grep -q "name=\"form-name\"[^>]*value=\"${form_name}\""; then
    pass 'hidden form-name input matches the form name'
  else
    fail "hidden form-name input does not match the form name \"${form_name}\" (submissions would be misrouted)"
  fi
fi

if printf '%s' "${form_block}" | grep -q 'name="bot-field"'; then
  pass 'bot-field honeypot input present'
else
  fail 'bot-field honeypot input is missing (spam protection disabled)'
fi

for field in name email; do
  if printf '%s' "${form_block}" | grep -q "name=\"${field}\""; then
    pass "form field \"${field}\" present"
  else
    fail "form field \"${field}\" is missing"
  fi
done

# --- The action target and the rewrite that makes it resolve ---

action_target="$(printf '%s' "${form_open_tag}" \
  | sed -n 's/.*action="\([^"]*\)".*/\1/p')"

if [[ -z "${action_target}" ]]; then
  fail 'form has no action attribute'
else
  pass "form action target is \"${action_target}\""

  target_path="${action_target#/}"

  # An extensionless action only works via a rewrite rule. Confirm the rule
  # exists in BOTH config files, since either alone would be load-bearing if
  # the other were removed.
  if [[ -f "${target_path}.html" ]] || [[ -f "${REPO_ROOT}/${target_path}.html" ]]; then
    pass "${target_path}.html exists to serve as the rewrite destination"
  else
    fail "${target_path}.html does not exist (the rewrite has no destination)"
  fi

  if [[ ! -f "${NETLIFY_TOML}" ]]; then
    fail 'netlify.toml is missing'
  elif grep -q "from = \"${action_target}\"" "${NETLIFY_TOML}" \
    && grep -q "to = \"/${target_path}.html\"" "${NETLIFY_TOML}" \
    && grep -q 'status = 200' "${NETLIFY_TOML}"; then
    pass "netlify.toml has the ${action_target} -> /${target_path}.html 200 rewrite"
  else
    fail "netlify.toml is missing the ${action_target} -> /${target_path}.html 200 rewrite (the form would submit into a 404)"
  fi

  if [[ ! -f "${REDIRECTS}" ]]; then
    fail '_redirects is missing'
  elif grep -Eq "^${action_target}[[:space:]]+/${target_path}\.html[[:space:]]+200" "${REDIRECTS}"; then
    pass "_redirects has the ${action_target} -> /${target_path}.html 200 rule"
  else
    fail "_redirects is missing the ${action_target} -> /${target_path}.html 200 rule"
  fi
fi

# --- The other pretty-URL rewrites the site's own links depend on ---

for page in privacy terms; do
  if [[ ! -f "${REPO_ROOT}/${page}.html" ]]; then
    fail "${page}.html is missing"
  elif grep -Eq "^/${page}[[:space:]]+/${page}\.html[[:space:]]+200" "${REDIRECTS}"; then
    pass "_redirects has the /${page} -> /${page}.html 200 rule"
  else
    fail "_redirects is missing the /${page} -> /${page}.html 200 rule"
  fi
done

printf '\n'
if ((failures > 0)); then
  printf '%d check(s) failed.\n' "${failures}" >&2
  exit 1
fi

printf 'All redirect contract checks passed.\n'

#!/usr/bin/env bash
# Verify what Netlify actually served, not just the files in the repo.
#
# scripts/check-redirect-contract.sh confirms the rewrite rules are present
# in netlify.toml and _redirects. It cannot confirm they WORK: pretty_urls
# processing, rule precedence between the two files, and edge routing are
# only observable once served. This exercises the live preview.
#
# Usage: check-deploy-preview.sh <preview-base-url>
#
# Exit 0 = the served site is sane, exit 1 = it is not.

set -euo pipefail

BASE_URL="${1:-}"

if [[ -z "${BASE_URL}" ]]; then
  printf 'usage: %s <preview-base-url>\n' "$(basename "$0")" >&2
  exit 2
fi

BASE_URL="${BASE_URL%/}"

# Floor sits well below the homepage's current served size (~18,900 bytes)
# rather than near it, so ordinary content edits do not fail CI as a false
# positive. It exists to catch a truncated or empty deploy, not to pin a
# page size. Raise it only if the homepage grows materially.
MIN_INDEX_BYTES=5000

failures=0

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  failures=$((failures + 1))
}

pass() {
  printf 'ok: %s\n' "$1"
}

fetch() {
  curl --silent --show-error --location \
    --max-time 30 --retry 2 --retry-delay 3 "${BASE_URL}$1"
}

http_status() {
  curl --silent --show-error --location \
    --max-time 30 --retry 2 --retry-delay 3 \
    --output /dev/null --write-out '%{http_code}' \
    "${BASE_URL}$1"
}

# --- Every route a visitor can reach, including the extensionless ones ---
#
# /thank-you, /privacy and /terms exist ONLY as 200-rewrites. If a rewrite
# rule is dropped these 404 while every .html file is still present and
# valid, which is precisely the failure the file-level checks cannot see.
for path in / /privacy /terms /thank-you; do
  status="$(http_status "${path}")"
  if [[ "${status}" == "200" ]]; then
    pass "${path} returned 200"
  else
    fail "${path} returned ${status} (expected 200)"
  fi
done

# --- The rewrite must serve real content, not just any 200 ---
#
# A 200 alone is not proof: a catch-all or a custom 404 page can return 200
# with the wrong body. Assert the served /thank-you is actually the
# confirmation page.
thankyou_html="$(fetch "/thank-you")"

if printf '%s' "${thankyou_html}" | grep -qi 'thank'; then
  pass '/thank-you served the confirmation page content'
else
  fail '/thank-you returned 200 but its body does not look like the confirmation page (the rewrite may resolve to the wrong file)'
fi

# --- Homepage, as served ---

home_html="$(fetch "/")"
home_bytes="${#home_html}"

if ((home_bytes >= MIN_INDEX_BYTES)); then
  pass "homepage body is ${home_bytes} bytes"
else
  fail "homepage body is only ${home_bytes} bytes (expected >= ${MIN_INDEX_BYTES}; deploy looks truncated or empty)"
fi

# --- The form contract, as served ---
#
# Netlify strips data-netlify from the served markup after consuming it at
# build time, so registration is confirmed via the hidden form-name input
# instead. This site authors that input by hand, so it must survive to the
# wire either way.
# Netlify's post-processing re-quotes attributes (double quotes become
# single), so the form block is matched quote-agnostically. Anchoring on
# double quotes alone silently matches nothing against a healthy deploy.
served_form="$(printf '%s' "${home_html}" \
  | tr -d '\r' \
  | sed -n "/<form[^>]*class=[\"']contact-form[\"']/,/<\/form>/p")"

if [[ -z "${served_form}" ]]; then
  fail 'served homepage has no contact form block'
else
  pass 'served homepage contains the contact form'

  if printf '%s' "${served_form}" \
    | grep -Eq "name=[\"']form-name[\"'][^>]*value=[\"']contact-form[\"']|value=[\"']contact-form[\"'][^>]*name=[\"']form-name[\"']"; then
    pass 'served form carries the form-name field (form is registered)'
  else
    fail 'served form lacks its form-name field (submissions would be misrouted or lost)'
  fi

  if printf '%s' "${served_form}" | grep -Eq "name=[\"']bot-field[\"']"; then
    pass 'served form retains the bot-field honeypot'
  else
    fail 'served form is missing the bot-field honeypot'
  fi

  for field in name email; do
    if printf '%s' "${served_form}" | grep -Eq "name=[\"']${field}[\"']"; then
      pass "served form field \"${field}\" present"
    else
      fail "served form field \"${field}\" is missing"
    fi
  done

  if printf '%s' "${served_form}" | sed -n '1p' \
    | grep -Eq "action=[\"']/thank-you[\"']"; then
    pass 'served form action points at /thank-you'
  else
    fail 'served form action is not /thank-you'
  fi
fi

# NOTE: deliberately NOT implemented -- an apex-domain redirect check.
# Sending a "Host:" header for tnjcleaning.com at a preview URL is answered
# by Netlify's platform-level domain routing, not by this deploy: an
# unrelated netlify.app site returns an identical 301, so the check passes
# even against a deploy that does not exist. It reads as coverage while
# testing nothing. Netlify's own "Redirect rules" commit status already
# validates that config. See issue #45.

printf '\n'
if ((failures > 0)); then
  printf '%d check(s) failed.\n' "${failures}" >&2
  exit 1
fi

printf 'Deploy preview checks passed against %s\n' "${BASE_URL}"

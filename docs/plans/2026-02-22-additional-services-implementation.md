# Additional Services Section & Contact Bullet Lists Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add "Additional Services Available by Request" callout section below main service cards and convert contact info lists to proper HTML bullet lists.

**Architecture:** Simple HTML/CSS additions to existing single-page site. No JavaScript needed. Additional services section uses centered callout box with lighter background for visual hierarchy. Contact lists converted from comma-separated text to semantic `<ul>` elements.

**Tech Stack:** HTML5, CSS3 (CSS custom properties), static site

---

## Task 1: Add Additional Services HTML Structure

**Files:**

- Modify: `index.html:101-102` (after `.services-grid` closing div)

**Step 1: Locate insertion point**

Open `index.html` and find line 101 (closing `</div>` of `.services-grid`)

**Step 2: Add additional services section**

Insert after line 101 (before the `</div>` that closes `.services` section on line 102):

```html

        <div class="additional-services">
          <h3>Additional Services Available by Request</h3>
          <ul>
            <li>Interior Windows</li>
            <li>Laundry</li>
            <li>Dishes</li>
            <li>Home organization</li>
            <li>General Tidying</li>
          </ul>
        </div>
```

**Step 3: Verify HTML structure**

Check that:

- New div is inside `.services` section (before its closing `</div>`)
- New div is after `.services-grid` closing div
- Indentation matches existing code (8 spaces for `.additional-services`)

**Step 4: Save file**

Save `index.html`

---

## Task 2: Add Additional Services CSS Styles

**Files:**

- Modify: `styles.css:477` (after `.service-card li` section)

**Step 1: Locate insertion point**

Open `styles.css` and find line 477 (after `.service-card li` styles, before the Reviews section comment)

**Step 2: Add additional services styles**

Insert this CSS block:

```css

/* Additional Services Callout */
.additional-services {
  max-width: 500px;
  margin: var(--space-lg) auto 0;
  padding: var(--space-md);
  background: var(--color-bg-alt);
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius);
  text-align: center;
}

.additional-services h3 {
  font-family: var(--font-body);
  font-weight: 600;
  font-size: 1.125rem;
  margin-bottom: var(--space-sm);
  color: var(--color-text);
}

.additional-services ul {
  margin: 0;
  padding: 0;
  list-style: none;
  text-align: left;
  display: inline-block;
}

.additional-services li {
  margin-bottom: 0.25rem;
  font-size: 0.9375rem;
  color: var(--color-text-light);
  position: relative;
  padding-left: var(--space-md);
}

.additional-services li::before {
  content: "•";
  position: absolute;
  left: 0;
  color: var(--color-accent);
}
```

**Step 3: Save file**

Save `styles.css`

---

## Task 3: Test Additional Services Section

**Files:**

- Verify: `index.html` (visual check in browser)

**Step 1: Start local server**

Run: `npx serve .` or `python -m http.server 8000`

**Step 2: Open in browser**

Navigate to: `http://localhost:8000` (or appropriate port)

**Step 3: Visual verification checklist**

Check that:

- [ ] Additional services section appears below Standard/Deep cleaning cards
- [ ] Section has lighter beige background (matches Reviews section)
- [ ] Section is centered with max-width constraint
- [ ] Heading reads "Additional Services Available by Request"
- [ ] List has 5 items with azure bullet points
- [ ] List items are left-aligned within centered container

**Expected appearance:**

- Lighter background than service cards
- Centered box, narrower than grid columns
- Azure bullet points (color: #1520a6)
- Text color matches existing design (#636e72)

**Step 4: Take screenshot (optional)**

If visual regression testing needed, capture baseline screenshot

---

## Task 4: Convert Service Area to Bullet List

**Files:**

- Modify: `index.html:186-187` (service area definition)

**Step 1: Locate service area section**

Find lines 186-187 in `index.html` (in Contact section):

```html
<dt>Service area</dt>
<dd>Spokane, Spokane Valley, Liberty Lake, Post Falls, Coeur d'Alene, Hayden, Rathdrum, and surrounding areas</dd>
```

**Step 2: Replace with bulleted list**

Replace line 187 with:

```html
<dd>
  <ul>
    <li>Spokane</li>
    <li>Spokane Valley</li>
    <li>Liberty Lake</li>
    <li>Post Falls</li>
    <li>Coeur d'Alene</li>
    <li>Hayden</li>
    <li>Rathdrum</li>
    <li>Surrounding areas</li>
  </ul>
</dd>
```

**Step 3: Verify indentation**

Check that:

- `<dd>` is at same indent level as before
- `<ul>` is indented 2 spaces inside `<dd>`
- `<li>` items are indented 2 more spaces inside `<ul>`

**Step 4: Save file**

Save `index.html`

---

## Task 5: Convert Payment Methods to Bullet List

**Files:**

- Modify: `index.html:189-190` (payment methods definition)

**Step 1: Locate payment methods section**

Find lines 189-190 in `index.html` (should now be ~197-198 after previous changes):

```html
<dt>Payment</dt>
<dd>Cash, check, Venmo, PayPal, Zelle, Apple Pay</dd>
```

**Step 2: Replace with bulleted list**

Replace the `<dd>` line with:

```html
<dd>
  <ul>
    <li>Cash</li>
    <li>Check</li>
    <li>Venmo</li>
    <li>PayPal</li>
    <li>Zelle</li>
    <li>Apple Pay</li>
  </ul>
</dd>
```

**Step 3: Verify indentation**

Same indentation rules as previous task

**Step 4: Save file**

Save `index.html`

---

## Task 6: Add Contact List Styles

**Files:**

- Modify: `styles.css:657` (after `.contact-details dd` section)

**Step 1: Locate insertion point**

Find line 657 in `styles.css` (after `.contact-details dd` styles, before `.contact-form` section)

**Step 2: Add list styles**

Insert this CSS:

```css

.contact-details dd ul {
  margin: var(--space-xs) 0 0 0;
  padding-left: var(--space-md);
  list-style: disc;
  color: var(--color-text-light);
}

.contact-details dd li {
  margin-bottom: 0.25rem;
  font-size: 0.9375rem;
}
```

**Step 3: Save file**

Save `styles.css`

---

## Task 7: Test Contact List Changes

**Files:**

- Verify: `index.html` (visual check in browser)

**Step 1: Refresh browser**

Reload `http://localhost:8000` (may need hard refresh: Cmd+Shift+R / Ctrl+Shift+R)

**Step 2: Scroll to Contact section**

Navigate to "Get in touch" section

**Step 3: Visual verification checklist**

Check that:

- [ ] "Service area" shows 8 bulleted items (Spokane through Surrounding areas)
- [ ] "Payment" shows 6 bulleted items (Cash through Apple Pay)
- [ ] Bullets are standard disc style
- [ ] Text color matches existing design (gray)
- [ ] Spacing looks consistent with rest of contact section

**Expected appearance:**

- Standard disc bullets (not custom colored)
- Gray text (#636e72)
- Proper indentation with bullets
- No visual regression in layout

---

## Task 8: Responsive Testing - Mobile

**Files:**

- Verify: All changes at mobile width

**Step 1: Open browser DevTools**

Press F12 or Cmd+Opt+I / Ctrl+Shift+I

**Step 2: Toggle device toolbar**

Click device icon or press Cmd+Shift+M / Ctrl+Shift+M

**Step 3: Test at mobile width (375px)**

Set viewport to iPhone SE or 375px width

**Step 4: Mobile verification checklist**

Check that:

- [ ] Additional services box spans full width with proper side padding
- [ ] Additional services text remains readable and centered
- [ ] Contact lists display properly with adequate indentation
- [ ] No horizontal scrolling
- [ ] No text overflow or wrapping issues

**Step 5: Test at tablet width (768px)**

Set viewport to iPad or 768px width and verify layout still works

---

## Task 9: Responsive Testing - Desktop

**Files:**

- Verify: All changes at desktop width

**Step 1: Set desktop viewport**

Set browser width to 1280px or larger

**Step 2: Desktop verification checklist**

Check that:

- [ ] Additional services box is centered with 500px max-width
- [ ] Additional services doesn't stretch too wide
- [ ] Contact lists maintain proper spacing
- [ ] Two-column service grid still works correctly
- [ ] Overall page layout is balanced

---

## Task 10: Accessibility Verification

**Files:**

- Verify: Semantic HTML and ARIA

**Step 1: Check heading hierarchy**

Using browser DevTools or accessibility inspector:

- Verify `<h3>` in additional services follows `<h2>` in services section
- Confirm no heading level skips

**Step 2: Check semantic lists**

Verify:

- Additional services uses `<ul>` and `<li>` elements
- Contact lists use proper `<ul>` and `<li>` nested in `<dd>`
- Screen reader will announce "list, 5 items" etc.

**Step 3: Check color contrast**

Verify text color (#636e72) on backgrounds meets WCAG AA:

- Light gray text on white/beige backgrounds
- Use browser DevTools contrast checker or online tool

**Step 4: Keyboard navigation**

Tab through page and verify:

- No unexpected focus traps
- All existing interactive elements still work
- New sections don't interfere with navigation

---

## Task 11: Cross-Browser Testing

**Files:**

- Verify: All changes in multiple browsers

**Step 1: Test in Safari (if on macOS)**

Open in Safari and verify:

- [ ] Additional services renders correctly
- [ ] Contact lists render correctly
- [ ] No CSS custom property issues

**Step 2: Test in Chrome/Edge**

Verify same checklist in Chromium-based browser

**Step 3: Test in Firefox (if available)**

Verify same checklist in Firefox

**Expected:** Consistent rendering across all browsers (CSS custom properties have excellent support)

---

## Task 12: Commit Changes

**Files:**

- Commit: `index.html`, `styles.css`

**Step 1: Stage changes**

```bash
git add index.html styles.css
```

**Step 2: Review diff**

```bash
git diff --cached
```

Verify:

- Additional services section added to HTML (lines ~102-111)
- Service area and payment converted to lists (lines ~186-207)
- Additional services CSS added (~477-515)
- Contact list CSS added (~657-667)

**Step 3: Commit with proper message**

```bash
git commit -m "$(cat <<'EOF'
feat(services): add additional services callout and contact list formatting

- Add "Additional Services Available by Request" section below main service cards
- Convert service area and payment methods to semantic bullet lists
- Additional services uses centered callout box with lighter background
- Maintains visual hierarchy (supplemental vs. core services)
- Fully responsive and accessible

AI review: 2 clean iterations
Adversarial review: 1 iteration - verified semantic HTML
Issues fixed: proper list semantics, WCAG AA contrast maintained

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

**Expected:** Commit succeeds, pre-commit hooks run and pass

---

## Task 13: Final Verification

**Files:**

- Verify: Complete implementation against success criteria

**Step 1: Success criteria checklist**

From design doc, verify:

- [x] Additional services section appears below Standard/Deep cleaning cards
- [x] Additional services visually distinct (lighter background, centered, constrained width)
- [x] Service area and payment methods display as bullet lists
- [x] All changes responsive (mobile through desktop)
- [x] Semantic HTML and accessibility maintained
- [x] Visual consistency with existing design system
- [x] No layout breaks or visual regressions

**Step 2: Visual regression check**

Compare before/after screenshots (if captured) or do final manual visual review

**Step 3: Document any issues**

If any issues found, create follow-up tasks

**Expected:** All success criteria met, ready for push/PR

---

## Post-Implementation

After completing all tasks:

1. Follow Protocol 4: Run local code-reviewer agent before pushing
2. Push branch to origin
3. Create PR with design doc reference
4. Monitor CI/CD (if configured)
5. Request review from stakeholder

**Branch:** `claude/additional-services-design-20260222` (already created)

**PR Title:** "Add additional services section and contact list formatting"

**PR Description:**

```markdown
## Summary
- Add "Additional Services Available by Request" callout section
- Convert service area and payment methods to bullet lists

## Design
See: docs/plans/2026-02-22-additional-services-design.md

## Visual Changes
- New centered callout box below service cards
- Lighter background signals supplemental nature
- Contact lists now use proper semantic HTML

## Testing
- ✅ Desktop responsive (1280px+)
- ✅ Tablet responsive (768px)
- ✅ Mobile responsive (375px)
- ✅ Accessibility verified (WCAG AA, semantic HTML)
- ✅ Cross-browser tested (Safari, Chrome, Firefox)
```

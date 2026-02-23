# Additional Services Section & Contact Info Bullet Lists

**Date:** 2026-02-22
**Project:** T&J Cleaning Website
**Status:** Approved

## Overview

Add a new "Additional Services Available by Request" section to the Services page and convert the contact section's service area and payment method lists from comma-separated text to proper bullet lists.

## Requirements

### 1. Additional Services Section

- Display supplemental/add-on services that can be requested with Standard or Deep cleaning
- Position below the existing 2-column service grid
- Visual hierarchy should indicate these are secondary/optional (not core offerings)
- Services to list:
  - Interior Windows
  - Laundry
  - Dishes
  - Home organization
  - General Tidying

### 2. Contact Info Bullet Lists

- Convert service area cities from comma-separated to bulleted list
- Convert payment methods from comma-separated to bulleted list
- Maintain existing visual hierarchy and spacing

## Design Approach

**Approach Selected:** Centered Callout Box (Approach 1)

**Rationale:**

- Clear visual hierarchy (positioned below main services, lighter background)
- Maintains design system consistency (card-based treatment)
- Signals "supplemental information" through centered layout and constrained width
- Scalable and flexible for future additions

**Alternatives Considered:**

- Third service card with badge - rejected as too prominent, would compete with core services
- Minimal text section - rejected as too lightweight, might be overlooked

## Detailed Design

### Additional Services Callout Box

**HTML Structure:**

```html
<!-- Position: After .services-grid, before closing .services section -->
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

**CSS Styling:**

```css
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

**Visual Hierarchy Signals:**

- Lighter background (`var(--color-bg-alt)` vs. service cards' `var(--color-bg)`)
- Smaller heading size (1.125rem vs. service cards' 1.25rem)
- Centered, constrained width (500px max vs. grid cells)
- Positioned below primary services with `var(--space-lg)` top margin

### Contact Info Bullet Lists

**HTML Changes:**

Service Area (lines 186-187):

```html
<dt>Service area</dt>
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

Payment Methods (lines 189-190):

```html
<dt>Payment</dt>
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

**CSS Styling:**

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

## Responsive Behavior

**Additional Services Callout:**

- Mobile: Full width with container padding
- Desktop: Max-width (500px) centers automatically
- No media queries needed

**Contact Info Lists:**

- Vertical stacking works naturally on all screen sizes
- Bullet indentation (`var(--space-md)`) appropriate for mobile and desktop
- No media queries needed

## Accessibility

**Semantic HTML:**

- Proper `<ul>` and `<li>` elements (screen-reader friendly)
- `<h3>` maintains heading hierarchy within Services section
- Definition list structure (`<dl>`, `<dt>`, `<dd>`) preserved in Contact section

**Screen Reader Experience:**

- Lists announced with item count ("list, 5 items", etc.)
- Natural reading order maintained
- No decorative elements requiring `aria-hidden`

**Color Contrast:**

- All text uses WCAG AA compliant color variables
- `var(--color-text-light)` (#636e72) on light backgrounds meets standards

**Keyboard Navigation:**

- No interactive elements, no focus management needed
- All text remains selectable

## Implementation Notes

1. Create feature branch: `claude/additional-services-contact-lists-<session-id>`
2. Edit `index.html`:
   - Add `.additional-services` div after line 101 (after `.services-grid`)
   - Replace service area text (lines 186-187) with bulleted list
   - Replace payment methods text (lines 189-190) with bulleted list
3. Edit `styles.css`:
   - Add `.additional-services` styles after `.service-card` section (~line 477)
   - Add `.contact-details dd ul` styles after `.contact-details dd` section (~line 657)
4. Test in browser (local server)
5. Verify responsive behavior at mobile/tablet/desktop widths
6. Run accessibility check (heading hierarchy, color contrast)
7. Commit with proper message format
8. Follow Protocol 4: Local review before push

## Success Criteria

- [ ] Additional services section appears below Standard/Deep cleaning cards
- [ ] Additional services visually distinct (lighter background, centered, constrained width)
- [ ] Service area and payment methods display as bullet lists
- [ ] All changes responsive (mobile through desktop)
- [ ] Semantic HTML and accessibility maintained
- [ ] Visual consistency with existing design system
- [ ] No layout breaks or visual regressions

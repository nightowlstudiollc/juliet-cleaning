# T&J Cleaning Website

## Project Overview

A simple, professional marketing website for a local house cleaning service based in Post Falls, Idaho, serving the Inland Northwest (Spokane, Spokane Valley, Coeur d'Alene area).

**Purpose:** Serve as a pre-qualification funnel before Thumbtack. Thumbtack charges $30 per contact regardless of conversion, so this site filters leads by:
1. Providing comprehensive information upfront (services, reviews, service area)
2. Collecting qualifying details via contact form (property type, service type)
3. Only sending serious prospects to the Thumbtack booking page

**Live Thumbtack profile:** https://www.thumbtack.com/id/post-falls/house-cleaning/tj-cleaning-llc/service/453572507345846278

---

## Design System

### Colors (CSS custom properties in `:root`)

| Variable | Value | Usage |
|----------|-------|-------|
| `--color-text` | `#2d3436` | Primary text |
| `--color-text-light` | `#636e72` | Secondary text |
| `--color-accent` | `#6b7c5e` | Sage green — primary accent |
| `--color-accent-light` | `#8a9a7c` | Lighter sage for gradients |
| `--color-bg` | `#fdfcfa` | Page background |
| `--color-bg-alt` | `#f5f3ef` | Section backgrounds |
| `--color-border` | `#e0dcd4` | Borders, dividers |
| `--color-white` | `#ffffff` | Card backgrounds |

### Typography

- **Headings:** Libre Baskerville (Google Fonts) — warm serif for credibility
- **Body:** Source Sans 3 (Google Fonts) — clean, readable sans-serif
- Both fonts loaded via Google Fonts CDN

### Visual Elements

- Decorative botanical SVG in hero (inline data URI)
- Dot pattern overlay in reviews section
- Gradient accent lines (header top, footer top)
- Animated underlines on nav links
- Service cards with hover-reveal accent bar
- Review cards with large decorative quotation marks
- Credentials displayed as pill-shaped tags

---

## File Structure

```
/
├── index.html      # Single-page site (all CSS inline in <style>)
├── CLAUDE.md       # This file
└── README.md       # (optional) Public-facing repo readme
```

Currently a single HTML file with all styles inline. If the site grows, consider extracting:
- `styles.css` — main stylesheet
- `images/` — if photos are added later

---

## Deployment

**Hosting:** Netlify (static site)
**Domain:** TBD (owner will purchase separately)
**Form handling:** Currently `action="#"` — needs Netlify Forms or similar

### To enable Netlify Forms:

1. Add `data-netlify="true"` to the `<form>` element
2. Add a hidden input for the form name:
   ```html
   <input type="hidden" name="form-name" value="contact">
   ```
3. Optionally add spam protection:
   ```html
   <input type="hidden" name="bot-field">
   ```
   And add `data-netlify-honeypot="bot-field"` to the form.

---

## Content Notes

### Business name
Currently "T&J Cleaning" throughout. The "T" refers to an ex-partner, so the business will likely be renamed. All instances are easy to find/replace:
- `<title>` tag
- `.site-title` link text
- Footer text
- Meta description (if updating)

### Service area
Spokane, Spokane Valley, Post Falls, Coeur d'Alene, Hayden, Rathdrum. Collectively referred to as "the Inland Northwest" in some copy.

### Reviews
Pulled from Thumbtack. All are real 5-star reviews with reviewer initials preserved. If adding more reviews, maintain the same format and keep them genuine.

### Credentials listed
- Background checked ✓
- Thumbtack Top Pro 2022 ✓
- 4+ years in business ✓
- Fully insured — *confirm this is accurate*

---

## Accessibility

- Semantic HTML throughout (`<header>`, `<main>`, `<nav>`, `<section>`, `<article>`, `<footer>`)
- Skip link for keyboard navigation
- Visible focus states on all interactive elements
- `aria-label` on star ratings
- Form inputs properly labeled
- Color contrast meets WCAG AA
- No motion that could trigger vestibular issues (all animations subtle and short)

---

## Future Considerations

1. **Photos:** The Thumbtack profile has 27 project photos. Could add a small gallery, but stock-photo-free design is intentional. Only add real work photos.

2. **Testimonial rotation:** If more reviews accumulate, consider a simple JS carousel or random selection on page load.

3. **Service pages:** If SEO becomes important, could break out individual service pages (deep cleaning, move-out cleaning, etc.) with more detailed content.

4. **Online booking:** Currently deferred to Thumbtack. If the $30/contact cost becomes prohibitive, could integrate a simple scheduling tool (Calendly, Acuity, etc.).

5. **Analytics:** Add Plausible, Fathom, or similar privacy-respecting analytics to track conversion funnel.

---

## Development Commands

```bash
# Local preview (any simple HTTP server)
npx serve .
# or
python -m http.server 8000

# Deploy to Netlify (if CLI installed)
netlify deploy --prod
```

---

## Contact

Website built for Juliet (T&J Cleaning, LLC).
Development assistance: [your contact info if desired]

# T&J Cleaning

[![Netlify Status](https://api.netlify.com/api/v1/badges/ca907e14-6ba9-4bb5-8885-6d03c52f4b7a/deploy-status)](https://app.netlify.com/projects/stalwart-toffee-8cdb4f/deploys)

A professional marketing website for a local house cleaning service in Post Falls, Idaho, serving the Inland Northwest.

## Live Site

[Coming soon - Netlify deployment pending]

## About

This website serves as a pre-qualification funnel for potential clients, providing:

- Comprehensive service information
- Customer reviews and testimonials
- Service area details (Spokane, Spokane Valley, Post Falls, Coeur d'Alene, Hayden, Rathdrum)
- Contact form for qualified leads

## Technology

- Pure HTML/CSS (no build process required)
- Responsive design with modern CSS features
- Accessible (WCAG AA compliant)
- Google Fonts: Libre Baskerville (headings) and Source Sans 3 (body)
- Netlify Forms for contact handling

## Local Development

Serve the site with any static HTTP server:

```bash
# Using npx
npx serve .

# Or Python
python -m http.server 8000
```

Then visit `http://localhost:8000` (or the appropriate port).

## Deployment

Hosted on Netlify. Push to `main` triggers automatic deployment.

To enable the contact form, Netlify Forms will need to be configured by adding:

- `data-netlify="true"` attribute on the form element
- Hidden `form-name` input for Netlify to detect the form
- Optional: `data-netlify-honeypot="bot-field"` for spam protection

## Project Structure

```
/
├── index.html      # Single-page site with inline CSS
├── CLAUDE.md       # Developer documentation and design system
├── README.md       # This file
└── .github/
    └── workflows/  # CI validation workflows
```

## Credits

Website built for Juliet (T&J Cleaning, LLC).

## License

Proprietary - all rights reserved.

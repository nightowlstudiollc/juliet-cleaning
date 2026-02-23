# Gallery Carousel — Design Document

**Date:** 2026-02-23
**Status:** Approved

---

## Overview

Add a photo gallery carousel above the Reviews section showcasing Juliet's cleaning work. 17 photos provided by the client. No before/after pairs — one image skipped (hybrid composite, unattractive).

---

## Approach

CSS `scroll-snap` track with ~25 lines of vanilla JS for prev/next buttons and counter sync. Touch/swipe works via native browser scroll at no cost. No external dependencies, no CDN, no build step.

---

## Section

- **ID / class:** `#gallery .gallery`
- **Heading:** "Our Work"
- **Placement:** Between Services (`order: 2`) and Reviews (`order: 3`)
  - Gallery: `order: 3`
  - Reviews: `order: 4`
  - About: `order: 5`
  - Contact: `order: 6`
- **Background:** `--color-bg` (white, same as Services, alternating with Reviews' `--color-bg-alt`)

---

## HTML Structure

```html
<section id="gallery" class="gallery">
  <div class="container">
    <h2>Our Work</h2>
    <div class="carousel" role="region" aria-label="Photo gallery">
      <div class="carousel-track">
        <div class="carousel-slide">
          <img src="images/gallery/IMG_2746.jpeg" alt="Cleaned home interior" loading="lazy">
        </div>
        <!-- × 17 slides -->
      </div>
      <button class="carousel-btn carousel-btn-prev" aria-label="Previous photo">&#8592;</button>
      <button class="carousel-btn carousel-btn-next" aria-label="Next photo">&#8594;</button>
    </div>
    <p class="carousel-counter" aria-live="polite">1 / 17</p>
  </div>
</section>
```

**Navigation:** "1 / 17" text counter (not individual dots — 17 dots would be visually noisy).

---

## CSS

Key rules:

```css
.carousel            { position: relative; overflow: hidden; }
.carousel-track      { display: flex; overflow-x: auto; scroll-snap-type: x mandatory;
                       scrollbar-width: none; }
.carousel-track::-webkit-scrollbar { display: none; }
.carousel-slide      { flex: 0 0 100%; scroll-snap-align: start; }
.carousel-slide img  { width: 100%; height: 400px; object-fit: cover; display: block; }
                       /* 260px on mobile */
.carousel-btn        { position: absolute; top: 50%; transform: translateY(-50%);
                       /* styled to match site design */ }
.carousel-counter    { text-align: center; font-size: 0.875rem; color: var(--color-text-light); }
```

---

## JavaScript (~25 lines, inline `<script>` at bottom of `<body>`)

```javascript
(function () {
  const track = document.querySelector('.carousel-track');
  const counter = document.querySelector('.carousel-counter');
  const total = track.children.length;
  let current = 0;

  function goTo(n) {
    current = Math.max(0, Math.min(n, total - 1));
    track.scrollTo({ left: current * track.offsetWidth, behavior: 'smooth' });
    counter.textContent = (current + 1) + ' / ' + total;
  }

  document.querySelector('.carousel-btn-prev').onclick = () => goTo(current - 1);
  document.querySelector('.carousel-btn-next').onclick = () => goTo(current + 1);

  track.addEventListener('scroll', () => {
    const index = Math.round(track.scrollLeft / track.offsetWidth);
    if (index !== current) {
      current = index;
      counter.textContent = (current + 1) + ' / ' + total;
    }
  });
})();
```

---

## Images

- **Source:** `/Users/andrewrich/Pictures/NOS/juliet/site-images/`
- **Destination:** `images/gallery/` (new subdirectory in project)
- **Skipped:** `8B47D9EF-C65C-43CE-9EB9-FEC819BBAC30.JPG` (hybrid composite, not suitable)
- **Resize:** max 1200px wide via macOS `sips` — reduces ~3MB originals to ~200–400KB
- **Display:** `height: 400px` desktop / `260px` mobile, `object-fit: cover`
- **Alt text:** Generic room descriptions; improvable later if Juliet adds captions
- **Loading:** `loading="lazy"` on all images

### Image list (17 files)

```
IMG_2746.jpeg   IMG_3067.jpg    IMG_3297.jpeg
IMG_2763.jpeg   IMG_3287.jpeg   IMG_3298.jpeg
IMG_2784.jpeg   IMG_3290.jpeg   IMG_3310.jpeg
IMG_2785.jpeg   IMG_3295.jpeg   IMG_3318.jpeg
IMG_2786.jpeg                   IMG_3363.jpeg
IMG_2788.jpeg                   IMG_3365.jpeg
IMG_2794.jpeg                   IMG_5005.jpeg
```

---

## Files Changed

| File | Change |
|------|--------|
| `index.html` | Add `<section id="gallery">` between services and reviews; add `<script>` block before `</body>` |
| `styles.css` | Add carousel styles; update `order:` values for gallery + downstream sections |
| `images/gallery/` | New directory — 17 resized images copied from source |
| `docs/plans/` | This document |

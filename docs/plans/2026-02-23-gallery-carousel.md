# Gallery Carousel Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a horizontal photo carousel ("Our Work") above the Reviews section, showing 18 client-home photos with prev/next arrow buttons and a "1 / 18" counter.

**Architecture:** CSS `scroll-snap` track for native smooth scrolling and free touch/swipe support; ~25 lines of vanilla JS for button navigation and counter sync; images resized to ≤1200px wide via macOS `sips` before being committed to the repo.

**Tech Stack:** Vanilla HTML/CSS/JS, macOS `sips` for image resizing. No test framework — verification is browser-based (open `index.html` directly).

**Correction:** Design doc says 17 photos; correct count is 18 (19 source files − 1 skipped composite).

---

## Task 1: Copy and resize images into the project

**Files:**

- Create: `images/gallery/` (new directory, 18 images)

**Step 1: Create the destination directory**

```bash
mkdir -p /Users/andrewrich/Developer/client/juliet-cleaning/images/gallery
```

**Step 2: Resize and copy all 18 images with `sips`**

`sips -Z 1200` resizes to fit within a 1200×1200 bounding box (preserves aspect ratio).
Run from the project root:

```bash
SOURCE="/Users/andrewrich/Pictures/NOS/juliet/site-images"
DEST="/Users/andrewrich/Developer/client/juliet-cleaning/images/gallery"

for f in \
  IMG_2746.jpeg IMG_2763.jpeg IMG_2784.jpeg IMG_2785.jpeg IMG_2786.jpeg \
  IMG_2788.jpeg IMG_2794.jpeg IMG_3067.jpg  IMG_3287.jpeg IMG_3290.jpeg \
  IMG_3295.jpeg IMG_3297.jpeg IMG_3298.jpeg IMG_3310.jpeg IMG_3318.jpeg \
  IMG_3363.jpeg IMG_3365.jpeg IMG_5005.jpeg; do
  sips -Z 1200 "$SOURCE/$f" --out "$DEST/$f"
done
```

**Step 3: Verify — file sizes should be dramatically smaller**

```bash
ls -lh /Users/andrewrich/Developer/client/juliet-cleaning/images/gallery/
```

Expected: 18 files, each roughly 150–400 KB (originals were 2–4 MB each).

**Step 4: Commit**

```bash
git add images/gallery/
git commit -m "chore(gallery): add resized gallery images (18 photos, ≤1200px)"
```

---

## Task 2: Add gallery section HTML and nav link

**Files:**

- Modify: `index.html`

**Step 1: Add "Gallery" to the nav**

In `index.html`, find the nav list:

```html
          <li><a href="#services">Services</a></li>
          <li><a href="#reviews">Reviews</a></li>
```

Insert a new `<li>` between them:

```html
          <li><a href="#services">Services</a></li>
          <li><a href="#gallery">Gallery</a></li>
          <li><a href="#reviews">Reviews</a></li>
```

**Step 2: Insert the gallery section**

In `index.html`, find the closing tag of the services section and the reviews comment:

```html
    </section>

    <!-- Reviews -->
```

Insert the entire gallery section between them:

```html
    </section>

    <!-- Gallery -->
    <section id="gallery" class="gallery">
      <div class="container">
        <h2>Our Work</h2>
        <div class="carousel" role="region" aria-label="Photo gallery">
          <div class="carousel-track">
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2746.jpeg" alt="Photo of a cleaned home" loading="eager">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2763.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2784.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2785.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2786.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2788.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_2794.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3067.jpg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3287.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3290.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3295.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3297.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3298.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3310.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3318.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3363.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_3365.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
            <div class="carousel-slide">
              <img src="images/gallery/IMG_5005.jpeg" alt="Photo of a cleaned home" loading="lazy">
            </div>
          </div>
          <button class="carousel-btn carousel-btn-prev" aria-label="Previous photo">&#8592;</button>
          <button class="carousel-btn carousel-btn-next" aria-label="Next photo">&#8594;</button>
        </div>
        <p class="carousel-counter" aria-live="polite">1 / 18</p>
      </div>
    </section>

    <!-- Reviews -->
```

**Step 3: Open in browser and verify**

```bash
open /Users/andrewrich/Developer/client/juliet-cleaning/index.html
```

Expected: A new section between Services and Reviews with a row of unstyled images stacked/overflowing. Looks broken — that's fine. CSS comes next. The images should load (not 404).

**Step 4: Commit**

```bash
git add index.html
git commit -m "feat(gallery): add gallery section HTML and nav link"
```

---

## Task 3: Add carousel CSS and update section ordering

**Files:**

- Modify: `styles.css`

**Step 1: Add the carousel CSS block**

In `styles.css`, find the `/* Reviews */` comment block. Insert the following immediately before it:

```css
/* ========================================
   Gallery / Carousel
   ======================================== */
.gallery {
  background: var(--color-white);
}

.carousel {
  position: relative;
  margin-top: var(--space-lg);
}

.carousel-track {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  scrollbar-width: none;
  -ms-overflow-style: none;
  border-radius: var(--border-radius);
}

.carousel-track::-webkit-scrollbar {
  display: none;
}

.carousel-slide {
  flex: 0 0 100%;
  scroll-snap-align: start;
}

.carousel-slide img {
  width: 100%;
  height: 400px;
  object-fit: cover;
  display: block;
  border-radius: var(--border-radius);
}

@media (max-width: 48rem) {
  .carousel-slide img {
    height: 260px;
  }
}

.carousel-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid var(--color-border);
  border-radius: 50%;
  width: 2.5rem;
  height: 2.5rem;
  cursor: pointer;
  font-size: 1rem;
  color: var(--color-text);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(42, 110, 172, 0.15);
  transition:
    background 0.2s ease,
    box-shadow 0.2s ease;
  z-index: 1;
}

.carousel-btn:hover {
  background: var(--color-white);
  box-shadow: 0 4px 12px rgba(42, 110, 172, 0.2);
}

.carousel-btn-prev {
  left: var(--space-sm);
}

.carousel-btn-next {
  right: var(--space-sm);
}

.carousel-counter {
  text-align: center;
  margin-top: var(--space-sm);
  font-size: 0.875rem;
  color: var(--color-text-light);
}

```

**Step 2: Update section ordering**

In `styles.css`, find the A/B test ordering block near the bottom:

```css
/* Default order (A): Services before About */
.hero {
  order: 1;
}
.services {
  order: 2;
}
.reviews {
  order: 3;
}
.about {
  order: 4;
}
.contact {
  order: 5;
}
```

Replace it with:

```css
/* Default order (A): Services → Gallery → Reviews → About → Contact */
.hero {
  order: 1;
}
.services {
  order: 2;
}
.gallery {
  order: 3;
}
.reviews {
  order: 4;
}
.about {
  order: 5;
}
.contact {
  order: 6;
}
```

**Step 3: Open in browser and verify layout**

```bash
open /Users/andrewrich/Developer/client/juliet-cleaning/index.html
```

Expected:

- "Our Work" section appears between Services and Reviews
- One photo visible at a time, `400px` tall, cropped to fill width
- Arrow buttons visible on left and right edges of the photo
- Counter reads "1 / 18" below the photo
- Scrolling the carousel track manually (dragging) advances photos and snaps cleanly
- Buttons do nothing yet (no JS)

Also check at `480px` width (DevTools → responsive mode): photo should be `260px` tall.

**Step 4: Commit**

```bash
git add styles.css
git commit -m "feat(gallery): add carousel CSS and update section ordering"
```

---

## Task 4: Add carousel JavaScript

**Files:**

- Modify: `index.html`

**Step 1: Add the script block**

In `index.html`, find the closing `</body>` tag:

```html
</body>
```

Insert immediately before it:

```html
  <script>
    (function () {
      var track = document.querySelector('.carousel-track');
      var counter = document.querySelector('.carousel-counter');
      if (!track || !counter) return;
      var slides = track.querySelectorAll('.carousel-slide');
      var total = slides.length;
      var current = 0;

      function goTo(n) {
        current = Math.max(0, Math.min(n, total - 1));
        track.scrollTo({ left: current * track.offsetWidth, behavior: 'smooth' });
        counter.textContent = (current + 1) + ' / ' + total;
      }

      document.querySelector('.carousel-btn-prev').addEventListener('click', function () { goTo(current - 1); });
      document.querySelector('.carousel-btn-next').addEventListener('click', function () { goTo(current + 1); });

      track.addEventListener('scroll', function () {
        var idx = Math.round(track.scrollLeft / track.offsetWidth);
        if (idx !== current) {
          current = idx;
          counter.textContent = (current + 1) + ' / ' + total;
        }
      });
    })();
  </script>
</body>
```

**Step 2: Open in browser and test buttons**

```bash
open /Users/andrewrich/Developer/client/juliet-cleaning/index.html
```

Expected:

- Click `→` button: smoothly advances to photo 2, counter updates to "2 / 18"
- Click `→` repeatedly through all 18: counter increments correctly
- At last photo, `→` does nothing (clamped)
- Click `←`: goes back, counter decrements
- At first photo, `←` does nothing

**Step 3: Test swipe / touch**

In Chrome DevTools, enable device simulation (any mobile preset). Drag the photo left/right.

Expected: snaps between photos, counter updates to match current position after drag settles.

**Step 4: Commit**

```bash
git add index.html
git commit -m "feat(gallery): add carousel JS for prev/next navigation and counter sync"
```

---

## Task 5: Code review and push

**Step 1: Run code review**

Use `superpowers:code-reviewer` (or the pre-push hook will run it automatically).

Fix any issues found, recommit.

**Step 2: Push and open PR**

```bash
git push -u origin claude/feat-gallery-carousel-20260223
gh pr create --title "feat(gallery): add Our Work photo carousel" --body "$(cat <<'EOF'
## Summary

- Adds an "Our Work" photo gallery carousel between the Services and Reviews sections
- 18 client-home photos, resized to ≤1200px wide for web performance
- CSS scroll-snap for smooth scrolling and free touch/swipe support
- Prev/next arrow buttons + "1 / 18" counter via ~25 lines of vanilla JS
- No external dependencies

## Test plan

- [ ] Section appears between Services and Reviews
- [ ] All 18 photos load (no broken images)
- [ ] Prev/next buttons navigate correctly, counter updates
- [ ] At first/last photo, buttons are clamped (don't error)
- [ ] Touch/swipe works on mobile (DevTools device sim)
- [ ] Counter syncs correctly after swipe
- [ ] Photo height: 400px desktop, 260px mobile
- [ ] Nav link "Gallery" scrolls to section

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

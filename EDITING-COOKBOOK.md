# Site Editing Cookbook

Quick recipes for common edits. For each task, I'll tell you exactly what to search for and what to change.

**Remember:** Edit on GitHub → Create pull request → Check the preview link → Merge when it looks right.

---

## Change the Phone Number

The phone number appears in **two places** in `index.html`. Update both.

**Search for:** `tel:+1`

You'll find something like:

```html
<a href="tel:+1-208-555-1234">(208) 555-1234</a>
```

Change both the `href="tel:..."` part AND the visible number between `>` and `</a>`.

---

## Change the Email Address

The email appears in **two places** in `index.html`. Update both.

**Search for:** `mailto:`

You'll find something like:

```html
<a href="mailto:tandjscleaningpf@gmail.com">tandjscleaningpf@gmail.com</a>
```

Change both the `href="mailto:..."` part AND the visible email between `>` and `</a>`.

---

## Change Business Hours

**Search for:** `Monday` or `hours`

You'll find something like:

```html
<dd>Monday–Saturday, 6:00 AM – 7:00 PM</dd>
```

Just change the text between `<dd>` and `</dd>`.

---

## Add a New Review

**Search for:** `review-card`

You'll see the existing reviews. To add a new one, copy an entire review block and paste it after the last one. A review block looks like this:

```html
<article class="review-card">
  <div class="review-stars" aria-label="5 out of 5 stars">★★★★★</div>
  <p class="review-text">"PUT THE REVIEW TEXT HERE"</p>
  <p class="review-author">— Name, service type or location</p>
</article>
```

Change:

- The text inside the quotes after `review-text">`
- The name and description after `review-author">—`

Leave the stars alone (unless it's not a 5-star review, which would be weird to feature).

---

## Update the Review Count

If you add reviews, update the count in two places.

**Search for:** `verified reviews`

You'll find something like:

```html
<strong>24</strong> verified reviews
```

Change the number.

**Also search for:** `from 24 reviews` (or whatever the current number is)

Update that number too.

---

## Change a Service Description

**Search for:** the service name, like `Deep Cleaning`

You'll find something like:

```html
<div class="service-card">
  <h3>Deep Cleaning</h3>
  <p>Intensive cleaning for move-ins, move-outs, or when your home needs extra attention.</p>
</div>
```

Change the text between `<p>` and `</p>`. Leave the `<h3>` title alone unless you're renaming the service.

---

## Add a City to the Service Area

**Search for:** `Rathdrum` (or any city currently listed)

You'll find the service area list. Just add your new city in the same format:

```html
Spokane, Spokane Valley, Post Falls, Coeur d'Alene, Hayden, Rathdrum, and surrounding areas
```

The service area is mentioned in a few places — use Ctrl+F / Cmd+F to find all instances and update them consistently.

---

## Change the Thumbtack Link

**Search for:** `thumbtack.com`

You'll find the Thumbtack profile URL in a couple of places. If your Thumbtack URL ever changes, update all instances.

---

## Things to NOT Touch

Unless you really know what you're doing, avoid editing:

- Anything that starts with `class="` or `id="`
- The `<head>` section at the top of the file
- The `<style>` section (that's all the visual design)
- Anything in `styles.css`
- The `netlify.toml` file

If you need changes to any of these, ask Andrew.

---

## If Something Looks Wrong in the Preview

1. **Don't panic.** The live site hasn't changed.
2. Close the pull request (there's a "Close pull request" button at the bottom).
3. Go back to `index.html` and try again.
4. If you're stuck, text Andrew.

---

## Quick Reference: Special Characters

If you need to use these characters in your text, use these codes instead:

| Character | Code | Example |
|-----------|------|---------|
| & | `&amp;` | `T&amp;J Cleaning` → T&J Cleaning |
| < | `&lt;` | (you probably won't need this) |
| > | `&gt;` | (you probably won't need this) |
| " | `&quot;` | inside attributes only |

For regular quotes in visible text, just type regular quotes — they'll work fine.

---

## Checklist Before Merging

Before you click "Merge pull request":

- [ ] Clicked the Netlify preview link
- [ ] The page loads without errors
- [ ] Your changes show up correctly
- [ ] Nothing else looks broken
- [ ] Checked on your phone too (the preview works on mobile)

If all good, merge it. The live site updates in about a minute.

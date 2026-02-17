# T&J Cleaning

[![Netlify Status](https://api.netlify.com/api/v1/badges/ca907e14-6ba9-4bb5-8885-6d03c52f4b7a/deploy-status)](https://app.netlify.com/projects/tnjcleaning/deploys)

Marketing website for T&J Cleaning, LLC, a house cleaning service in Post Falls, Idaho.

Live at [tnjcleaning.com](https://tnjcleaning.com).

## How to edit the site

You don't need any special software. Everything happens on GitHub in your browser.

### Quick version

1. Open [index.html](index.html) and click the pencil icon to edit.
2. Find the text you want to change (Ctrl+F or Cmd+F to search).
3. Edit the words between the HTML tags, not the tags themselves.
4. Click "Commit changes", then "Create pull request", then "Create pull request" again.
5. Wait about a minute. Netlify will post a "Deploy Preview" link on your pull request so you can see how the change looks before it goes live.

That's it. The live site doesn't change until the pull request is approved and merged.

### What are HTML tags?

Tags are the bits in angle brackets. Here's a heading on the site:

```html
<h1>Professional Cleanings for the Inland Northwest</h1>
```

The `<h1>` and `</h1>` are tags. The words between them are what shows on the page. Change the words, leave the tags alone.

A link looks like this:

```html
<a href="mailto:tandjscleaningpf@gmail.com">tandjscleaningpf@gmail.com</a>
```

To change the email, you'd update it in both places (the `href="mailto:..."` part and the visible text between `>` and `</a>`).

### What you can change yourself

- Headings and paragraph text
- Phone number and email address
- Service descriptions and prices
- Review quotes and reviewer names
- Cities in the service area

For anything structural (new sections, layout changes, adding photos), ask Andrew.

### What if I break something?

You won't break the live site. Pull requests are a staging area. If the preview looks wrong, close the pull request and try again. Nothing happens to tnjcleaning.com until a change is explicitly approved.

Even in the worst case, every change is tracked in Git's history and can be rolled back in seconds.

## Technical notes

Plain HTML and CSS, no build step, no framework. Hosted on Netlify with automatic deploys on push to `main`. Contact form handled by Netlify Forms.

### Files

```
index.html      Main page
styles.css      Stylesheet
privacy.html    Privacy policy
terms.html      Terms of service
thank-you.html  Form submission confirmation
netlify.toml    Netlify config (redirects, build settings)
_redirects      Additional redirect rules
images/         Favicon and site images
```

### Local development

Any static HTTP server works:

```bash
npx serve .
```

## Credits

Site built for Juliet (T&J Cleaning, LLC) by [Night Owl Studio](https://github.com/nightowlstudiollc).

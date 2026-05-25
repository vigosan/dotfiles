---
description: Make a website feel like a native iOS app when added to Home Screen. Use when building PWAs, configuring web manifests, splash screens, or fixing iOS-specific mobile web quirks. Triggers on: PWA, iOS, standalone, webmanifest, Add to Home Screen, splash screen, status bar, notch, safe-area-inset, viewport-fit, tap highlight, user-scalable.
---

# iOS Web App Feel

Source: https://samselikoff.com/blog/8-tips-to-make-your-website-feel-like-an-ios-app

## 1. Develop with Xcode Simulator

Use real iOS Safari instead of Chrome devtools.
`Xcode > Open Developer Tool > Simulator`, then visit `localhost:3000` from the simulated Safari.

## 2. Standalone app

Own tab in App Switcher, no Safari chrome.

```json
// public/site.webmanifest
{ "display": "standalone" }
```

```html
<link rel="manifest" href="/site.webmanifest" />
```

## 3. Short name

Override `<title>` on the Home Screen shortcut.

```json
{ "display": "standalone", "short_name": "Fitness" }
```

## 4. Icons + splash screens

```sh
npx pwa-asset-generator public/icon.svg public \
  -m public/site.webmanifest \
  --padding "calc(50vh - 25%) calc(50vw - 25%)" \
  -b "linear-gradient(135deg, #2fb9e4, #ff0098)" \
  -q 100 \
  -i public/asset-generator-changes.html \
  --favicon
```

Requires an empty `public/asset-generator-changes.html` first. Copy the generated `<link>` tags into your `<head>`.

## 5. Transparent status bar

```html
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="viewport" content="initial-scale=1, viewport-fit=cover" />
```

Account for the notch using `env()` safe-area insets (preferred over a `display-mode: standalone` media query height bump).

Tailwind: expose a `standalone:` prefix.

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      screens: { standalone: { raw: "(display-mode: standalone)" } },
    },
  },
};
```

## 6. Fixed header + safe insets

```html
<header class="fixed">…</header>
<main class="mt-11 pt-safe-top">…</main>
```

Use `safe-*` spacing (env safe-area insets) so content clears the notch.

## 7. Disable pinch zoom

```html
<meta name="viewport" content="initial-scale=1, viewport-fit=cover, user-scalable=no" />
```

Stops accidental zoom while navigating. Leave on if zoom is legitimately useful.

## 8. Kill tap highlight

```css
body { -webkit-tap-highlight-color: transparent; }
```

Replace with intentional `:hover` / `:focus` / `:active` styles that match the app's look.

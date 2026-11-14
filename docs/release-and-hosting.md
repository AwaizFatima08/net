# Release and hosting kit: Prep Simulator for NET

## Build
- Package `com.homilabs.net_prep` (locked after the first Play upload). Version 1.0.0 (versionCode 1).
- Build: `jobq run --name net-release-aab -- flutter build appbundle --release`, then `./gradlew --stop` in `android/`.
- Before every release: `bash scripts/check-release-ad-ids.sh`, `python3 tool/validate.py`, `flutter test`, and re-check the dated facts in `content/guide_src.py` against nust.edu.pk.
- Signing: upload key created 9 Nov 2026: `.secrets/net-upload.keystore` (alias `net-upload`, RSA 2048, valid 10,000 days), passwords in `.secrets/net-upload-keystore-credentials.txt`, read by `android/key.properties`. Certificate SHA-256 `AD:0A:84:2A:EA:E4:B9:65:19:A4:E1:06:26:39:EE:B6:DA:2F:76:6F:8C:BB:69:BD:C2:C4:EE:77:BE:8E:28:67`. `.secrets/` goes to the local and Drive backups, never GitHub. Losing it means asking Play support for an upload-key reset.
- Release 1.0.0+1 built 9 Nov 2026: `releases/1.0.0+1/net-prep-1.0.0+1.aab` (SHA-256 `72153ee35690b8cf13a86613d0e4b8ae359fb1cac682eba32f28fe080eb2b732`) and `.apk` (sideload test; smoke-tested on the Tab S9).

## Website: https://net.homilabs.org
- Hostinger: subdomain `net.homilabs.org` (folder `public_html/net`), created 9 Nov 2026 in hPanel → homilabs.org → Domains → Subdomains. DNS is Hostinger's (dns-parking.com) and resolved at once; SSL was issued within minutes.
- Pages: landing, `/privacy.html`, `/terms.html`, `/app-ads.txt`.
- Change `website/`, commit, then `bash scripts/publish-site.sh` (pushes `deploy`, then pulls it on the server over SSH). Flush the CDN cache in hPanel if pages look stale.
- Play link on the landing page since 14 Nov 2026. Still to do: add the app to homilabs.org.

## AdMob (account homilabs.smc@gmail.com)
- Created 9 Nov 2026: app "Prep Simulator for NET", App ID `ca-app-pub-2087846699268567~7211622553`; units banner `net_home_banner` (`/1299006233`) and interstitial `net_results_interstitial` (`/9610555188`) (ids in `config/admob.json`). Debug builds use Google test units.
- Play store linked 14 Nov 2026 (AdMob → Apps → Add store, com.homilabs.net_prep); AdMob's own app review takes 2-3 days, ads stay limited until it passes. `app-ads.txt` is already on the site.
- Privacy & messaging: "Prep Simulator for NET consent" (European regulations, this app only, privacy URL https://net.homilabs.org/privacy.html, "Do not consent" on for all countries) published 9 Nov 2026 (Homi's go-ahead).

## Play Console
- HomiLabs organization account (developer id 9161588402757830740), app id 4974767593974247789. Created 9 Nov 2026.
- Filled in 9 Nov 2026: all 10 App content declarations (privacy policy, ads: yes, no sign-in, content rating IARC: All Other App Types, educational, No to everything else; target age 16-17 and 18+; data safety: App interactions and Device or other IDs collected and shared for Advertising, required, encrypted in transit, no accounts; advertising ID: yes, advertising; not a government app; no financial or health features), store settings (Education, homilabs.smc@gmail.com, https://net.homilabs.org), en-US listing (icon, feature graphic, 7 screenshots), production release 1 (1.0.0) to 177 countries plus rest of world. **Sent for review 9 Nov 2026; live on Google Play by 14 Nov 2026** (https://play.google.com/store/apps/details?id=com.homilabs.net_prep).
- Misleading Claims policy: the sibling NLE app was rejected on 7 Nov 2026 for missing official source links and a not-a-government-entity disclaimer. The NET listing description, About screen and website all carry both (links to nust.edu.pk and ugadmissions.nust.edu.pk).
- After approval (done 14 Nov 2026): AdMob store linked, site Play link live. Left: add the app to homilabs.org.
- Launch social kit (poster, story, reel, captions): `/mnt/storage/projects/marketing/net-launch-2026-11/`.
- Uploads from the built-in browser: the AAB (49 MB) is too large for the Chrome extension's 10 MB upload; it was staged briefly at an unguessable path on net.homilabs.org, fetched into the page's file input, then deleted and the CDN cache flushed.

| Item | Value |
|---|---|
| App icon 512×512 | `store-assets/icon-512.png` |
| Feature graphic | `store-assets/feature-graphic.png` |
| Privacy policy URL | https://net.homilabs.org/privacy.html |
| Website | https://net.homilabs.org |
| Contact email | homilabs.smc@gmail.com |
| Ads | Yes (AdMob banner on home tabs; one interstitial after results or practice) |
| App access | All functionality available without login |
| Category | Education |

**App name** (22 characters): `Prep Simulator for NET`

**Short description** (80 max): `NUST Entry Test practice: 20 NET mocks, subject MCQs, every answer explained`

## Before production (open items)
- Homi reviews the guide (dated facts), a sample of questions per subject and `docs/review-flags.md`.
- Trademark: "NET" and "NUST" are used descriptively, with the not-affiliated notice in the About screen, listing and website.
- ~~Phone screenshots~~ done 9 Nov 2026 (`store-assets/screenshots/`).

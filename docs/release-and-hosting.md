# Release and hosting kit: Prep Simulator for NET

## Build
- Package `com.homilabs.net_prep` (locked after the first Play upload). Version 1.0.0 (versionCode 1).
- Build: `jobq run --name net-release-aab -- flutter build appbundle --release`, then `./gradlew --stop` in `android/`.
- Before every release: `bash scripts/check-release-ad-ids.sh`, `python3 tool/validate.py`, `flutter test`, and re-check the dated facts in `content/guide_src.py` against nust.edu.pk.
- Signing: no upload key yet. Create `.secrets/net-upload.keystore` and `android/key.properties` before the first release build (as for csca); `.secrets/` goes to the local and Drive backups, never GitHub.

## Website: https://net.homilabs.org
- Hostinger: subdomain `net.homilabs.org` (folder `public_html/net`), created 9 Nov 2026 in hPanel → homilabs.org → Domains → Subdomains. DNS is Hostinger's (dns-parking.com) and resolved at once; SSL was issued within minutes.
- Pages: landing, `/privacy.html`, `/terms.html`, `/app-ads.txt`.
- Change `website/`, commit, then `bash scripts/publish-site.sh` (pushes `deploy`, then pulls it on the server over SSH). Flush the CDN cache in hPanel if pages look stale.
- After Play launch: replace "Coming soon on Google Play" with the Play link, and add the app to homilabs.org.

## AdMob (account homilabs.smc@gmail.com)
- Created 9 Nov 2026: app "Prep Simulator for NET", App ID `ca-app-pub-2087846699268567~7211622553`; units banner `net_home_banner` (`/1299006233`) and interstitial `net_results_interstitial` (`/9610555188`) (ids in `config/admob.json`). Debug builds use Google test units.
- "Limited ad serving" until the Play listing is live. Then: AdMob → Apps → this app → Add store (com.homilabs.net_prep). `app-ads.txt` is already on the site.
- Privacy & messaging: "Prep Simulator for NET consent" (European regulations, this app only, privacy URL https://net.homilabs.org/privacy.html, "Do not consent" on for all countries) saved as a **draft** on 9 Nov 2026. **Homi publishes it** (AdMob → Privacy & messaging → European regulations → the draft → Publish).

## Play Console (not started)
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

**Short description** (80 max): `NUST Entry Test mocks: 20 full NET-Engineering papers, every answer explained.`

## Before production (open items)
- Homi reviews the guide (dated facts), a sample of questions per subject and `docs/review-flags.md`.
- Trademark: "NET" and "NUST" are used descriptively, with the not-affiliated notice in the About screen, listing and website.
- Phone screenshots for the listing (`tool/screenshots/store_screenshots_test.dart`).

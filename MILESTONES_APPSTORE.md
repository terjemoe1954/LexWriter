# LexWriter App Store Milestones

Last updated: 2026-09-21

## Goal

Keep `LexWriter` stable, trustworthy, and legally clear after its App Store launch, then move deliberately into the paid version by improving the product experience before premium access is enforced.

## Current Status

- `LexWriter` has been live on the App Store for a few days.
- The original pre-launch readiness work is now considered complete enough for the first public release.
- The app already contains StoreKit plumbing, a premium screen, and document access tiers, but premium locking is currently disabled in code.
- Premium badges are now visible in the app, while all documents remain available.
- The home screen now labels the premium-marked section as planned premium templates while StoreKit is disabled.
- Settings now includes access, premium preview, privacy information, and a count summary for the current free/premium-marked split.
- The user guide and home screen now explain that documents are templates and drafts, not legal advice.
- Premium copy now clearly explains that paid premium is planned for a later version and that purchases are not available in this version.
- Added unit coverage for the premium-preview footer explaining that all documents are currently available.
- The next phase should combine post-launch monitoring, product polish, and premium-readiness work before submitting a paid/premium update.

## Completed in This Post-Launch Pass

- Enabled visible `Gratis` / `Premium` document badges without enabling premium locks.
- Added unit coverage for localized badge text across every free and premium-marked document.
- Added unit coverage for the expected supported app languages: Norwegian, English, and Thai.
- Added unit coverage for the expected premium product id.
- Added premium product id label to the premium-preview localization coverage.
- Updated the premium-marked home section title so it reads as planned premium while purchases are disabled.
- Split monetization flags into clear responsibilities: badges, StoreKit availability, and premium enforcement.
- Added tests that guard the current free/premium document split and ensure premium enforcement stays off for now.
- Tightened the free/premium split test so both the free and premium document lists are exact.
- Added unit coverage for the current free documents: purchase agreement, receipt, and loan agreement now check required-field validation, advisory warnings, generated document text, and HTML escaping for preview/PDF safety.
- Added first premium-marked validation coverage for power of attorney.
- Added premium-marked validation coverage for debt instrument.
- Added premium-marked validation coverage for employment agreement.
- Added premium-marked validation coverage for NDA.
- Added premium-marked validation coverage for rental agreement.
- Added premium-marked validation coverage for cohabitation agreement.
- Added premium-marked validation coverage for rental termination.
- Added premium-marked validation coverage for contract.
- Added premium-marked validation coverage for testament.
- Added HTML-preview escaping coverage for testament.
- Added HTML-preview escaping coverage for power of attorney.
- Added HTML-preview escaping coverage for debt instrument.
- Added HTML-preview escaping coverage for employment agreement.
- Added HTML-preview escaping coverage for NDA.
- Added HTML-preview escaping coverage for rental agreement.
- Added HTML-preview escaping coverage for cohabitation agreement.
- Added HTML-preview escaping coverage for rental termination.
- Added HTML-preview escaping coverage for contract.
- Made `PremiumView` safe for the current pre-purchase phase: it explains that paid premium is planned later, says purchases are not available in this version, hides purchase controls while StoreKit is disabled, and uses the App Store purchase disclaimer only when purchases are enabled.
- Added a premium preview entry point in Settings.
- Added Settings sections for access status, free/premium template counts, premium preview, and privacy.
- Added user guide text explaining free/premium badges.
- Added a home-screen legal note that documents are templates and drafts, not legal advice.
- Improved document card layout so long titles and badges fit better on small screens.
- Hardened `PurchaseManager` around product loading, restore state, repeated restore taps, and unverified transaction errors.
- Made `PurchaseManager` testable with injectable `UserDefaults` while keeping `.standard` as the app default.
- Updated SwiftUI previews for `HomeView`, `SettingsView`, and `PremiumView` so each has the required `PurchaseManager` environment.
- Updated unit and UI test expectations for the current premium-preview wording.
- Current validation baseline: app build succeeds, build-for-testing succeeds, and 42 unit tests pass. UI tests compile but cannot run until the Xcode `LexWriterUITests` target application path is fixed.
- Added `RELEASE_CHECKLIST.md` for future App Store submissions.
- Added `PREMIUM_ACTIVATION.md` with the exact preconditions and flags for enabling purchases later.
- Added `KNOWN_LIMITATIONS.md` for support replies, App Store review notes, and release planning.
- Added `APPSTORE_SUBMISSION_NOTES.md` as a working draft for release notes, review notes, and screenshots.
- Added `SUPPORT_RESPONSES.md` with draft replies for legal scope, privacy, premium, saving, and export questions.
- Added `VERSION_1_1_CANDIDATES.md` as the working shortlist for the first post-launch update.
- Checked Apple field-performance tooling for `com.terjemoe.LexWriter` versions `1.0.1` and `1.0`; versions were listed initially, but hangs, launch, and disk-write datasets returned no available data. Crash tooling did not resolve the product and should be checked manually in Xcode Organizer or App Store Connect.

## Milestone 1: First Live Signals

- Check App Store Connect daily for crashes, install numbers, ratings, and review text.
- Watch for recurring support questions about document scope, legal responsibility, language, or printing.
- Verify that the live App Store listing, screenshots, privacy details, age rating, and app category still match the shipped app.
- Keep a short changelog of anything users report, even if it does not become an immediate fix.

## Milestone 2: Stability and Trust Before Monetization

- Re-test the highest-risk flows on the App Store build: field entry, preview, printing, language switching, settings, and premium/paywall behavior if enabled.
- Review all disclaimers again in the live product, especially for wills, debt instruments, and other higher-risk documents.
- Confirm that privacy messaging is easy to find before users enter sensitive personal information.
- Check that every document can still be previewed and printed cleanly on at least one smaller iPhone, one larger iPhone, and iPad.

## Milestone 3: Premium Version Readiness

- Confirm the final premium model: lifetime unlock first, with no subscription unless there is a clear support or content reason.
- Verify that the App Store Connect in-app purchase product matches the app product id: `com.lexwriter.premium.lifetime`.
- Decide exactly which documents remain free and which are premium before turning on premium enforcement.
- Follow `PREMIUM_ACTIVATION.md` when enabling StoreKit or premium enforcement.
- Keep the premium screen copy aligned with the current activation phase: planned premium now, purchase/restore value copy only when StoreKit is enabled.
- Test purchase, restore purchase, pending purchase, cancelled purchase, and offline product-loading states with StoreKit testing before release.
- Only enable premium locking after the purchase product, pricing, App Store metadata, and smoke tests are ready.

## Milestone 4: Product Improvements

- Improve the App Store subtitle, description, and keywords based on what the app actually does best after launch.
- Prepare localized App Store metadata updates for Norwegian and English.
- Maintain `APPSTORE_SUBMISSION_NOTES.md` before each App Store submission.
- Decide whether Thai metadata should be added now or later.
- Add or replace screenshots if the current listing does not clearly show the main document flow and print preview.
- Improve the first-time experience so users understand that documents are templates, not legal advice.
- Review whether the home screen should surface the most useful free documents more clearly before locked premium templates.

## Milestone 5: Version 1.1 Scope

- Fix any crash, layout, localization, or printing issue found during the first days live.
- Add validation tests for the highest-risk premium-marked document types if they are not already covered.
- Tighten long-text handling in print layouts and signature sections.
- Improve the most confusing first-time-user area before adding new document types.
- Consider enabling premium badges before enforcing premium locks, so users can see the future product structure without being blocked.

## Milestone 6: Legal and Product Quality

- Review every template against current Norwegian legal requirements and standard market practice.
- Keep conservative wording around legal claims in both the app and App Store listing.
- Separate "general template" documents from higher-risk documents in the user guide or explanatory text.
- Decide whether a lawyer or legal reviewer should review the live `1.1` wording before submission.

## Milestone 7: Operational Readiness

- Keep support email, privacy policy, and any terms links active and consistent with App Store Connect.
- Maintain `RELEASE_CHECKLIST.md` for version number, build number, archive, TestFlight smoke test, and App Store submission.
- Maintain `KNOWN_LIMITATIONS.md` so App Store responses and support replies stay consistent.
- Maintain `SUPPORT_RESPONSES.md` as recurring support questions appear.
- Decide a normal release rhythm for small fixes versus larger feature releases.

## Recommended Next Build Order

1. Check App Store Connect for crashes, ratings, reviews, installs, and product-page performance.
2. Do a live-build smoke test on device for language selection, document creation, preview, printing, settings, and current premium entry points.
3. Decide the free-versus-premium document split and the initial lifetime price.
4. Test the lifetime unlock product in StoreKit and App Store Connect sandbox.
5. Maintain `VERSION_1_1_CANDIDATES.md` from real issues first, then premium-readiness polish.
6. Add or update validation tests for the premium-marked document types with the highest legal or UX risk.
7. Fix the `LexWriterUITests` target application path if UI automation should be part of the release gate.
8. Prepare updated App Store metadata and screenshots for the paid/premium version.
9. Enable premium enforcement only after the product id, price, screenshots, metadata, and restore flow are confirmed.

## Open Questions

- What date should be treated as the official App Store launch date in release notes and marketing?
- Are there any App Store Connect crashes, reviews, or support emails from the first days live?
- Which document flow should be considered the most important to polish for version `1.1`?
- What should the first lifetime unlock price be?
- Should premium be turned on in version `1.1`, or should `1.1` only prepare the app and leave locking for `1.2`?
- Do you want local save/export later, or should the app stay print-first?
- Do you want a lawyer or legal reviewer involved before the first post-launch update?

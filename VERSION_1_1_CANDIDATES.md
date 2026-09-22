# LexWriter 1.1 Candidate Plan

Last updated: 2026-09-22

Use this as the working shortlist for the first post-launch update. Keep the scope conservative unless real user feedback or App Store data points to something urgent.

## Release Intent

Version 1.1 should be a trust, polish, and premium-preparation release. It should not enable paid purchases or premium locking unless StoreKit setup, sandbox testing, screenshots, metadata, and restore behavior are all confirmed.

## Must Have

- Keep all documents available in the app.
- Keep StoreKit product loading disabled.
- Keep purchase and restore controls hidden.
- Keep premium enforcement disabled.
- Preserve clear legal-scope messaging: documents are templates and drafts, not legal advice.
- Verify app build, build-for-testing, unit tests, UI tests, and launch test before archive.
- Check App Store Connect or Xcode Organizer manually for crashes and user feedback.

## Strong Candidates

- Smoke test every document flow on at least one small iPhone, one large iPhone, and iPad.
- Review print/PDF output for the highest-risk templates: testament, power of attorney, debt instrument, employment agreement, and NDA.
- Improve any long text, field label, or signature layout issue found during smoke testing.
- Prepare App Store metadata that explains the current free/premium preparation state without implying that purchases are available.
- Add or update screenshots if the listing does not clearly show document creation and print preview.

## Completed Candidate Work

- Updated the App Store milestones so premium badges are treated as visible-and-unlocked state, not future work.
- Added unit coverage for Home screen localization across every supported app language.
- Added unit coverage for home-screen legal-scope copy across Norwegian, English, and Thai.
- Added unit coverage for Settings privacy copy across Norwegian, English, and Thai.
- Added unit coverage for Settings section and app-info localization across every supported app language.
- Added unit coverage for User Guide access, privacy, and legal-scope copy across Norwegian, English, and Thai.
- Added unit coverage for User Guide localization completeness across every supported app language.
- Added unit coverage for stable document order and identifiers.
- Added unit coverage for distinct document titles and subtitles across every supported app language.
- Added unit coverage for document card titles and subtitles across every supported app language.
- Added unit coverage for distinct document card icons.
- Added unit coverage for document checklist titles and checklist items across every supported app language.
- Added unit coverage for document preview button labels across every supported app language.
- Added unit coverage for print-preview controls across every supported app language.
- Added unit coverage for validation and requirement messages across every supported app language.
- Tightened unit coverage for the exact free/premium document split.
- Tightened premium safety coverage for the locking defaults key and disabled internal testing controls.
- Added unit coverage that keeps each document's access tier aligned with the monetization plan.
- Added unit coverage for the expected premium product id.
- Added premium product id label to the premium-preview localization coverage.
- Added unit coverage for localized badge text across every free and premium-marked document.
- Added unit coverage for the expected supported app languages and stable language identifiers: Norwegian, English, and Thai.
- Added unit coverage for stable appearance identifiers and localized appearance labels.
- Added full PremiumView localization coverage, including exact Thai premium-preview/status copy used in the premium-preparation flow.
- Added unit coverage that keeps App Store submission notes and support response drafts aligned with the current premium-preparation state.
- Added unit coverage that keeps the release checklist aligned with disabled StoreKit, hidden purchase/restore controls, disabled premium enforcement, and current UI-test status.
- Added unit coverage that keeps App Store metadata drafts aligned with print/PDF positioning and legal-scope wording.
- Added unit coverage that keeps App Store review notes and screenshot guidance aligned with the premium-preparation state.
- Added unit coverage that keeps Norwegian App Store review notes explicit about premium preparation, unavailable purchases, and all documents remaining available.
- Added unit coverage that keeps the App Store screenshot checklist focused on the core document flow, Settings, print/PDF controls, and the Premium preview caveat.
- Added screenshot-priority guidance so normal stability or premium-preparation updates lead with Home, document editor, print/PDF preview, and Settings before any Premium preview screenshot.
- Added unit coverage that keeps the `LexWriterUITests` target application pointed at `LexWriter`.
- Updated UI tests so each run resets language and appearance state, and verified `LexWriterUITests` passes with 7/7 plus the launch test passes with 1/1.
- Stabilized the Settings app-info UI test by scrolling to the build label before asserting it.
- Stabilized the Premium preview UI test with dedicated accessibility identifiers for the planned-premium headline, included-documents heading, and unavailable-purchases message, opened through the UI-test-only `-openPremiumPreviewUITest` launch route.
- Added unit coverage that keeps the Premium preview UI-test launch route documented as test-only and separate from StoreKit, purchases, restore, and premium enforcement.
- Completed a manual simulator smoke test covering Home, Settings, Premium preview, language switching, one free document, one premium-marked document, and empty Will preview validation.
- Added unit coverage that keeps support response drafts aligned with PDF saving limits, no full document history/cloud sync, and print/PDF troubleshooting details.
- Added support troubleshooting wording for print/PDF issues involving long fields, free text, and signature sections.
- Added unit coverage that keeps support premium replies explicit about all documents remaining available and future App Store Connect product setup/testing.
- Added unit coverage that keeps known limitations visible for legal scope, storage limits, premium preparation, StoreKit, and current UI-test status.
- Added unit coverage that keeps the premium activation guide explicit about product setup, sandbox/restore testing, activation flags, and the two-release recommendation.
- Added unit coverage that keeps the premium activation guide explicit about the current free and premium-marked document split.
- Added unit coverage that keeps this 1.1 plan explicit about deferring StoreKit, purchase/restore controls, premium enforcement, and document locking.
- Added unit coverage that keeps the Codex handoff aligned with the current premium-preparation state, UI-test status, validation baseline, and safe-session instructions.
- Added unit coverage that keeps the App Store milestone order explicit about stability before monetization and premium enforcement only after product, price, screenshots, metadata, and restore flow are confirmed.
- Added unit coverage that keeps the recommended next build order conservative: live signals and smoke testing before StoreKit sandbox work and premium enforcement.
- Added unit coverage that keeps the release checklist explicit about version/build, smoke tests, App Store Connect checks, archive, and TestFlight validation.
- Added unit coverage that keeps the release checklist explicit about product smoke-test scope across devices, core screens, document creation, PDF output, and language switching.
- Added a release-checklist device and document matrix for small iPhone, large iPhone, iPad, and highest-risk template smoke testing.
- Added release-checklist print/PDF review criteria for clipping, overlap, advisory text, signature/completion sections, and Norwegian, English, and Thai character rendering.
- Added release-checklist guidance to run unit tests, UI tests, and launch tests separately if the full active test plan leaves an incomplete `.xcresult`.
- Added release-checklist guidance to run the launch test before archive.
- Added unit coverage that keeps the release checklist explicit about legal/trust review and higher-risk templates before release.
- Added unit coverage that keeps the release checklist explicit about App Store Connect checks, screenshots, privacy details, support email, and privacy policy links.
- Added release-checklist guidance to mention print/PDF layout improvements for long fields and signature sections when included in the build.
- Added unit coverage that keeps App Store release notes aligned with premium-preparation, unavailable purchases, free/premium labels, and legal-scope wording.
- Added App Store release-note wording for improved print/PDF layout around long fields and signature sections.
- Added unit coverage that keeps App Store keyword drafts focused on document, print, and PDF search terms rather than active premium purchase wording.
- Added unit coverage that keeps support replies conservative about legal-advice scope and high-risk situations before signing.
- Added unit coverage for the premium-preview footer explaining that all documents are currently available.
- Added unit coverage for the free document set: purchase agreement, receipt, and loan agreement now check required-field validation, advisory warnings, generated body text, and HTML escaping for preview/PDF safety.
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
- Added unit coverage that keeps printable HTML-preview and signature structure present across every document template.
- Added `overflow-wrap` to printable HTML signature lines so long names, addresses, and labels wrap more safely in preview/PDF output.
- Added `overflow-wrap` to printable HTML paper containers so long free-text fields wrap more safely in preview/PDF output.
- Added printable HTML signature page-break protection so signature blocks are less likely to split across printed/PDF pages.
- Added unit coverage that keeps the completed-candidate work list free of duplicate bullets.
- Updated `PREMIUM_ACTIVATION.md` so the current test baseline and UI-test target guidance match the stabilized release gate.
- Reverified the separate validation gates after premium activation guide baseline cleanup: unit tests 84/84, build-for-testing, app build, UI tests 7/7, and launch test 1/1.
- Reverified unit tests after milestone coverage status sync: unit tests 84/84.
- Reverified build-for-testing after latest unit validation: succeeded.
- Reverified app build after latest build-for-testing validation: succeeded.
- Reverified UI tests after latest app build validation: UI tests 7/7.
- Stabilized the Testament preview-validation UI test with dedicated accessibility identifiers.

## Technical Candidates

- Run `LexWriterUITests` as a separate validation step if UI automation should become part of the release gate.
- Take Xcode `Update to recommended settings` as a separate maintenance commit after reviewing the generated project changes.
- Add unit tests for additional premium-marked document validation logic where the legal or UX risk is highest.

## Defer Until Premium Activation

- Enabling `isPremiumStoreEnabled`.
- Enabling `enforcesPremiumAccess`.
- Showing purchase or restore buttons.
- Advertising premium purchase availability in App Store metadata.
- Locking premium-marked documents.

## Open Decisions

- 1.1 should remain premium-preparation only; paid premium and premium locking should wait for a later release after StoreKit, metadata, screenshots, and restore behavior are confirmed.
- What should the first lifetime unlock price be?
- Which document flow should get the first deeper polish pass?
- Should a legal reviewer check the highest-risk templates before the next App Store submission?

# LexWriter 1.1 Candidate Plan

Last updated: 2026-09-21

Use this as the working shortlist for the first post-launch update. Keep the scope conservative unless real user feedback or App Store data points to something urgent.

## Release Intent

Version 1.1 should be a trust, polish, and premium-preparation release. It should not enable paid purchases or premium locking unless StoreKit setup, sandbox testing, screenshots, metadata, and restore behavior are all confirmed.

## Must Have

- Keep all documents available in the app.
- Keep StoreKit product loading disabled.
- Keep purchase and restore controls hidden.
- Keep premium enforcement disabled.
- Preserve clear legal-scope messaging: documents are templates and drafts, not legal advice.
- Verify build, build-for-testing, and unit tests before archive.
- Check App Store Connect or Xcode Organizer manually for crashes and user feedback.

## Strong Candidates

- Smoke test every document flow on at least one small iPhone, one large iPhone, and iPad.
- Review print/PDF output for the highest-risk templates: testament, power of attorney, debt instrument, employment agreement, and NDA.
- Improve any long text, field label, or signature layout issue found during smoke testing.
- Prepare App Store metadata that explains the current free/premium preparation state without implying that purchases are available.
- Add or update screenshots if the listing does not clearly show document creation and print preview.

## Completed Candidate Work

- Added unit coverage for the free document set: purchase agreement, receipt, and loan agreement now check required-field validation, advisory warnings, generated body text, and HTML escaping for preview/PDF safety.
- Added first premium-marked validation coverage for power of attorney.
- Added premium-marked validation coverage for debt instrument.
- Added premium-marked validation coverage for employment agreement.
- Added premium-marked validation coverage for NDA.
- Added premium-marked validation coverage for rental agreement.
- Added premium-marked validation coverage for cohabitation agreement.

## Technical Candidates

- Fix or recreate `LexWriterUITests` so the UI test target has `LexWriter` as its target application.
- Take Xcode `Update to recommended settings` as a separate maintenance commit after reviewing the generated project changes.
- Add unit tests for additional premium-marked document validation logic where the legal or UX risk is highest.

## Defer Until Premium Activation

- Enabling `isPremiumStoreEnabled`.
- Enabling `enforcesPremiumAccess`.
- Showing purchase or restore buttons.
- Advertising premium purchase availability in App Store metadata.
- Locking premium-marked documents.

## Open Decisions

- Should 1.1 remain premium-preparation only, or should paid premium wait for 1.2?
- What should the first lifetime unlock price be?
- Which document flow should get the first deeper polish pass?
- Should a legal reviewer check the highest-risk templates before the next App Store submission?

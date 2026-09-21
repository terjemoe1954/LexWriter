# LexWriter Release Checklist

Use this checklist before submitting a new App Store build.

## Version and Build

- Confirm the intended version number and build number.
- Update App Store Connect release notes for Norwegian and English using `APPSTORE_SUBMISSION_NOTES.md`.
- Review subtitle, short description, and keyword drafts in `APPSTORE_SUBMISSION_NOTES.md`.
- Confirm whether the release is a stability update, premium-preparation update, or premium-enforcement update.

## Product Smoke Test

- Launch the app on a small iPhone, large iPhone, and iPad.
- Check home screen layout, document badges, legal note, Settings, User Guide, and Premium preview.
- Confirm Settings shows the current access status, free/premium template counts, and the planned-premium entry point.
- Confirm Premium preview says purchases are not available in this version while StoreKit is disabled.
- Create at least one free document and one premium-marked document.
- Preview, print, and save PDF from a representative document.
- Switch language between Norwegian, English, and Thai and confirm the main labels update.

## Premium Readiness

- Review `PREMIUM_ACTIVATION.md`.
- For a premium-preparation release, confirm StoreKit loading, purchase buttons, restore buttons, and premium enforcement are still disabled.
- Confirm `com.lexwriter.premium.lifetime` exists in App Store Connect before enabling purchases.
- Confirm price, localization, review screenshot, and product description.
- Test product loading, purchase, restore, cancelled purchase, pending purchase, and offline product loading.
- Keep premium enforcement disabled unless purchase product, metadata, screenshots, and smoke tests are complete.

## Legal and Trust

- Review `KNOWN_LIMITATIONS.md`.
- Confirm the home screen legal note is visible.
- Confirm Settings includes access and privacy information.
- Confirm the User Guide explains that documents are templates and drafts, not legal advice.
- Review higher-risk templates before release, especially testament, debt instrument, power of attorney, employment agreement, and NDA.

## App Store Connect

- Review `APPSTORE_SUBMISSION_NOTES.md`.
- Review `SUPPORT_RESPONSES.md` for expected support and review wording.
- Check crashes, hangs, reviews, ratings, installs, and product page performance.
- Confirm privacy details still match the app.
- Confirm screenshots match the shipped UI.
- Do not include Premium preview screenshots unless the App Store listing explains the premium-preparation state.
- Confirm support email and privacy policy links are active.

## Final Validation

- Build the app in Xcode.
- Build with test targets.
- Run unit tests.
- Run UI tests only after the `LexWriterUITests` target application path is fixed; until then, confirm build-for-testing succeeds.
- Archive the exact build intended for submission.
- Submit to TestFlight first for a final smoke test.

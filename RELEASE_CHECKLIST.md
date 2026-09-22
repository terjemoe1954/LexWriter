# LexWriter Release Checklist

Use this checklist before submitting a new App Store build.

## Version and Build

- Confirm the intended version number and build number.
- Update App Store Connect release notes for Norwegian and English using `APPSTORE_SUBMISSION_NOTES.md`.
- Review subtitle, short description, and keyword drafts in `APPSTORE_SUBMISSION_NOTES.md`.
- Confirm whether the release is a stability update, premium-preparation update, or premium-enforcement update.

## Product Smoke Test

- Launch the app on a small iPhone, large iPhone, and iPad.
- Record device model, iOS version, app version/build, date checked, and pass/fail result for each smoke-test device.
- Check home screen layout, document badges, legal note, Settings, User Guide, and Premium preview.
- Confirm Settings shows the current access status, free/premium template counts, and the planned-premium entry point.
- Confirm Premium preview says purchases are not available in this version while StoreKit is disabled.
- Create at least one free document and one premium-marked document.
- Preview, print, and save PDF from a representative document.
- Switch language between Norwegian, English, and Thai and confirm the main labels update.

Device and document matrix:

- Small iPhone: verify Home, Settings, Premium preview, one free document editor, one premium-marked document editor, and print/PDF preview.
- Large iPhone: verify document card layout, long field labels, validation messages, preview spacing, and signature sections.
- iPad: verify navigation, form width, print/PDF preview, language switching, and Settings/User Guide readability.
- Highest-risk templates: review testament, power of attorney, debt instrument, employment agreement, and NDA for required-field validation, advisory warnings, preview layout, and signature/completion text.

Print/PDF review:

- Record document type, language, device, date checked, and pass/fail result for each print/PDF review.
- Confirm long names, addresses, dates, amounts, and free-text fields do not clip or overlap in preview or exported PDF.
- Confirm advisory warnings and legal-scope text remain readable before printing or saving.
- Confirm signature, place, date, witness, and completion sections are present where the document type requires them.
- Confirm Norwegian, English, and Thai characters render correctly in the preview/PDF path.

## Premium Readiness

- Review `PREMIUM_ACTIVATION.md`.
- For a premium-preparation release, confirm StoreKit loading, purchase buttons, restore buttons, and premium enforcement are still disabled.
- Confirm `com.lexwriter.premium.lifetime` exists in App Store Connect before enabling purchases.
- Confirm price, localization, review screenshot, and product description.
- Test product loading, purchase, restore, cancelled purchase, pending purchase, and offline product loading.
- Keep premium enforcement disabled unless purchase product, metadata, screenshots, and smoke tests are complete.

## Legal and Trust

- Record reviewer, date checked, scope, and pass/fail result for the legal/trust review.
- Review `KNOWN_LIMITATIONS.md`.
- Confirm the home screen legal note is visible.
- Confirm Settings includes access and privacy information.
- Confirm the User Guide explains that documents are templates and drafts, not legal advice.
- Review higher-risk templates before release, especially testament, debt instrument, power of attorney, employment agreement, and NDA.

## App Store Connect

- Review `APPSTORE_SUBMISSION_NOTES.md`.
- Record the date checked and result for crashes, hangs, reviews, ratings, installs, product page performance, privacy details, screenshots, support email, and privacy policy links.
- Confirm release notes mention the print/PDF layout improvements for long fields and signature sections when included in the build.
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
- Run UI tests if UI automation is part of this release gate; the `LexWriterUITests` target application should point to `LexWriter`.
- Run the launch test before archive.
- If the full active test plan leaves an incomplete `.xcresult`, run unit tests, UI tests, and launch tests as separate validation steps.
- Archive the exact build intended for submission.
- Submit to TestFlight first for a final smoke test.

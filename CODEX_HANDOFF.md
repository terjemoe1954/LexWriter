# LexWriter Codex Handoff

Last updated: 2026-09-22

## Current Goal

LexWriter is live on the App Store. The current workstream is preparing a later paid/premium version while keeping the live app stable, clear, and fully usable.

## Current Premium State

- Premium badges are visible.
- All documents remain available.
- StoreKit product loading is disabled.
- Purchase and restore buttons are hidden.
- Premium enforcement is disabled.
- Settings explains that all documents are open now.
- Settings shows 3 free templates and 9 planned premium templates.
- The home screen labels the premium-marked section as planned premium templates while StoreKit is disabled.
- Premium preview says paid premium is planned later and purchases are not available in this version.

## Current Free/Premium Split

Free:

- Purchase Agreement / Kjøpskontrakt
- Receipt / Kvittering
- Loan Agreement / Låneavtale

Premium-marked but still available:

- Will / Testament
- Contract / Kontrakt
- Power of Attorney / Fullmakt
- Rental Agreement / Husleiekontrakt
- Cohabitation Agreement / Samboeravtale
- Debt Instrument / Gjeldsbrev
- Termination of Tenancy / Oppsigelse av leieforhold
- Employment Agreement / Arbeidsavtale
- NDA

## Important Files

- `Config/DocumentCatalog.swift`: premium flags and document split.
- `Views/Premium/PremiumView.swift`: premium preview and future purchase UI.
- `Views/Settings/SettingsView.swift`: access status, premium plan entry point, privacy/app info.
- `Services/PurchaseManager.swift`: StoreKit plumbing and premium access state.
- `Localization/AppLocalization.swift`: shared localized app text.
- `LexWriterTests/LexWriterTests.swift`: unit coverage for supported app languages and stable language identifiers, stable appearance identifiers, Home localization, Settings localization, stable document order/identifiers, distinct document titles/subtitles, document card titles/subtitles/icons, document checklist titles/items, document preview button labels, print-preview controls, validation and requirement messages, home legal-scope copy, Settings privacy copy, User Guide localization and access/privacy/legal-scope copy, full PremiumView localization including Thai copy, exact free/premium document split, access-tier/monetization-plan consistency, premium safety flags/defaults, release/support/checklist premium-preparation wording, release checklist submission validation, release checklist device/document matrix, release checklist print/PDF review criteria, release checklist legal/trust review, release checklist App Store Connect checks, App Store metadata draft legal/print scope, App Store keyword scope, App Store review/screenshot scope including Norwegian review-note premium-preparation wording, support saving/print scope, support print/PDF troubleshooting details, support legal-advice and premium-availability scope, known-limitations release risks, premium activation preconditions, version 1.1 premium deferral, test-only Premium preview launch-route documentation, handoff safe-session instructions, App Store milestone premium-readiness order, printable HTML-preview/signature structure across all documents, printable HTML signature-line and paper-container `overflow-wrap` protection, printable HTML signature page-break protection, premium product identifier, badge text across all documents, free-document validation/output safety, power-of-attorney validation, power-of-attorney HTML-preview escaping, debt-instrument validation, debt-instrument HTML-preview escaping, employment-agreement validation, employment-agreement HTML-preview escaping, NDA validation, NDA HTML-preview escaping, rental-agreement validation, rental-agreement HTML-preview escaping, cohabitation-agreement validation, cohabitation-agreement HTML-preview escaping, rental-termination validation, rental-termination HTML-preview escaping, contract validation, contract HTML-preview escaping, testament validation, and testament HTML-preview escaping.
- `LexWriterUITests/LexWriterUITests.swift`: UI test expectations updated; target application points to `LexWriter`, UI tests reset language/appearance state on launch, Settings app-info assertions scroll to the build label, Premium preview assertions use stable identifiers through a UI-test-only launch route, Testament preview validation uses stable identifiers, and UI tests pass.
- `VERSION_1_1_CANDIDATES.md`: working shortlist for the first post-launch update.

## Validation Baseline

- Unit tests: 84/84 passed.
- UI tests: 7/7 passed.
- Launch test: 1/1 passed.
- Full active test plan can leave an incomplete `.xcresult`; when that happens, run unit tests, UI tests, and launch tests as separate validation steps.
- Build for testing: succeeded.
- App build: succeeded.
- Latest separate validation run on 2026-09-22 after premium activation guide baseline cleanup: unit tests 84/84 passed, build-for-testing succeeded, app build succeeded, UI tests 7/7 passed, and launch test 1/1 passed.
- Manual simulator smoke test: passed for Home, Settings, Premium preview, language switching, one free document, one premium-marked document, and empty Will preview validation gate.
- Added supported-language and stable language identifier coverage, stable appearance identifier coverage, Home localization coverage, Settings localization coverage, stable document order/identifier coverage, distinct document title/subtitle coverage, document card title/subtitle/icon coverage, document checklist coverage, document preview button coverage, print-preview control coverage, validation/requirement message coverage, home legal-scope copy coverage, Settings privacy copy coverage, User Guide localization and access/privacy/legal-scope copy coverage, full PremiumView localization coverage including Thai copy, premium safety flag/defaults coverage, release/support/checklist premium-preparation wording coverage, release checklist submission validation coverage, release checklist product smoke-test scope coverage, release checklist device/document matrix coverage, release checklist print/PDF review criteria coverage, release checklist legal/trust review coverage, release checklist App Store Connect coverage, App Store release-notes premium-preparation scope coverage, App Store metadata draft legal/print scope coverage, App Store keyword scope coverage, App Store review/screenshot scope coverage including Norwegian review-note premium-preparation wording, App Store screenshot checklist coverage, UI test target-application coverage, support saving/print scope coverage, support print/PDF troubleshooting detail coverage, support legal-advice and premium-availability scope coverage, support privacy/local-processing scope coverage, known-limitations release risk coverage, premium activation precondition/current-baseline/document-split coverage, version 1.1 premium-deferral coverage, version 1.1 completed-work duplicate-bullet coverage, test-only Premium preview launch-route coverage, handoff safe-session instruction coverage, App Store milestone premium-readiness, visible-badges-without-locks, and next-build-order coverage, access-tier/monetization-plan consistency coverage, printable HTML-preview/signature structure coverage, printable HTML signature-line and paper-container `overflow-wrap` protection, printable HTML signature page-break protection, testament validation, premium product identifier coverage, badge text coverage across all documents, premium-preview footer copy coverage, and HTML-preview escaping coverage for all premium-marked document templates; unit tests pass with 84/84, build-for-testing succeeds, and app build succeeds.
- UI test target now points to `LexWriter`; UI tests pass with 7/7, and the launch test passes with 1/1.
- Manual simulator smoke confirmed all documents remain reachable, purchase/restore controls are absent, and empty Will preview validation is visible.
- Xcode still shows one yellow project warning: `Update to recommended settings`. Leave it for a separate commit.
- Apple field-performance datasets were unavailable for live versions `1.0.1` and `1.0`; crash tooling did not resolve the product, so crash status should be checked manually in Xcode Organizer or App Store Connect.

## UI Test Status

`LexWriterUITests` now has `LexWriter` as its target application. UI tests pass with 7/7 and the launch test passes with 1/1 after resetting language and appearance state with the `-resetUITestState` launch argument. Settings app-info assertions scroll to the build label before checking it, Premium preview and Testament preview-validation assertions use stable accessibility identifiers instead of visible copy, and the Premium preview test opens `PremiumView` through the UI-test-only `-openPremiumPreviewUITest` launch argument to avoid flaky Form sheet taps.

## Recommended Next Steps

1. Continue product polish using `VERSION_1_1_CANDIDATES.md` as the working shortlist.
2. Use `PREMIUM_ACTIVATION.md` before changing `isPremiumStoreEnabled` or `enforcesPremiumAccess`.
3. Check App Store Connect or Xcode Organizer manually for crashes until Apple tooling returns field data.

## Safe Instruction For A New Codex Session

Start with:

`Read CODEX_HANDOFF.md, MILESTONES_APPSTORE.md, PREMIUM_ACTIVATION.md, and RELEASE_CHECKLIST.md. Do not enable StoreKit or premium locking. Continue from the premium-preparation workstream.`

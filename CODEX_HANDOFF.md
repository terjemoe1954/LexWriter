# LexWriter Codex Handoff

Last updated: 2026-09-21

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
- `LexWriterTests/LexWriterTests.swift`: unit coverage for premium-preview state, free-document validation/output safety, power-of-attorney validation, debt-instrument validation, employment-agreement validation, NDA validation, rental-agreement validation, cohabitation-agreement validation, and rental-termination validation.
- `LexWriterUITests/LexWriterUITests.swift`: UI test expectations updated, but not runnable yet.
- `VERSION_1_1_CANDIDATES.md`: working shortlist for the first post-launch update.

## Validation Baseline

- Unit tests: 27/27 passed.
- Build for testing: succeeded.
- UI tests compile, but cannot run until `LexWriterUITests` target application path is fixed in Xcode.
- Xcode still shows one yellow project warning: `Update to recommended settings`. Leave it for a separate commit.
- Apple field-performance datasets were unavailable for live versions `1.0.1` and `1.0`; crash tooling did not resolve the product, so crash status should be checked manually in Xcode Organizer or App Store Connect.

## Known Blocker

`LexWriterUITests` cannot run because Xcode reports:

`UITargetAppPath should be provided`

The UI test target needs to be connected to the `LexWriter` app target, or recreated with the correct target application.

## Recommended Next Steps

1. Decide whether to fix or recreate the UI test target now or leave it for a separate technical cleanup.
2. Continue product polish using `VERSION_1_1_CANDIDATES.md` as the working shortlist.
3. Use `PREMIUM_ACTIVATION.md` before changing `isPremiumStoreEnabled` or `enforcesPremiumAccess`.
4. Check App Store Connect or Xcode Organizer manually for crashes until Apple tooling returns field data.

## Safe Instruction For A New Codex Session

Start with:

`Read CODEX_HANDOFF.md, MILESTONES_APPSTORE.md, PREMIUM_ACTIVATION.md, and RELEASE_CHECKLIST.md. Do not enable StoreKit or premium locking. Continue from the premium-preparation workstream.`

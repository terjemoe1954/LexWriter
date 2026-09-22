# LexWriter Premium Activation Guide

Use this only when the paid version is ready to test or submit.

## Current Intended State

- Premium badges are visible.
- All documents remain available.
- StoreKit product loading is disabled.
- Premium enforcement is disabled.
- Premium preview is available from Settings.
- Settings shows the current split as 3 free templates and 9 planned premium templates.
- Premium preview copy states that paid premium is planned later and purchases are not available in this version.
- Current test baseline: 84 unit tests pass, 7 UI tests pass, the launch test passes, app build succeeds, and build-for-testing succeeds. `LexWriterUITests` now points to `LexWriter`.

## Product Identifier

The app expects this lifetime unlock product:

`com.lexwriter.premium.lifetime`

Create and approve the same product identifier in App Store Connect before enabling StoreKit in the app.

## Current Free/Premium Split

Free documents:

- Purchase Agreement / Kjøpskontrakt
- Receipt / Kvittering
- Loan Agreement / Låneavtale

Premium-marked documents:

- Will / Testament
- Contract / Kontrakt
- Power of Attorney / Fullmakt
- Rental Agreement / Husleiekontrakt
- Cohabitation Agreement / Samboeravtale
- Debt Instrument / Gjeldsbrev
- Termination of Tenancy / Oppsigelse av leieforhold
- Employment Agreement / Arbeidsavtale
- NDA

## Before Enabling Purchases

- Confirm the lifetime product exists in App Store Connect.
- Confirm price, display name, description, and localized metadata.
- Confirm App Store screenshots and review notes explain the premium model.
- Test the product in StoreKit local testing or sandbox.
- Confirm restore purchases works.
- Confirm cancelled, pending, unavailable, and offline product-loading states are acceptable.
- Re-run unit tests, UI tests, the launch test, app build, and build-for-testing.
- Confirm `LexWriterUITests` still points to `LexWriter` if UI automation is used as a release gate.

## Activation Flags

The premium flags live in `Config/DocumentCatalog.swift`.

Keep this enabled:

```swift
static let showsPremiumBadges = true
```

Enable StoreKit product loading and purchase UI:

```swift
static let isPremiumStoreEnabled = true
```

Enable actual document locking only after purchase testing is complete:

```swift
static let enforcesPremiumAccess = true
```

## Release Recommendation

Prefer two separate releases:

1. Premium-preparation release: badges, explanations, Settings, and premium preview, with no locked documents.
2. Premium-enforcement release: StoreKit enabled and premium documents locked after sandbox/TestFlight validation.

This keeps the risk lower if App Store Connect product setup or restore behavior needs adjustment.

## Current Validation Notes

- Latest separate validation sequence on 2026-09-22 after milestone/status sync: unit tests 84/84 passed, build-for-testing succeeded, app build succeeded, UI tests 7/7 passed, and launch test 1/1 passed.
- `PurchaseManager` supports injectable `UserDefaults` for isolated tests.
- Premium preview localization is covered for every supported app language.
- Premium preview UI assertions use stable accessibility identifiers instead of visible copy and open through a UI-test-only launch route; this does not enable StoreKit, purchases, restore, or premium enforcement.
- StoreKit purchase and restore buttons stay hidden while `isPremiumStoreEnabled` is `false`.
- The old generic "coming later" wording has been removed from active app localization; premium preview uses more specific copy.

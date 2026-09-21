# LexWriter Premium Activation Guide

Use this only when the paid version is ready to test or submit.

## Current Intended State

- Premium badges are visible.
- All documents remain available.
- StoreKit product loading is disabled.
- Premium enforcement is disabled.
- Premium preview is available from Settings.

## Product Identifier

The app expects this lifetime unlock product:

`com.lexwriter.premium.lifetime`

Create and approve the same product identifier in App Store Connect before enabling StoreKit in the app.

## Before Enabling Purchases

- Confirm the lifetime product exists in App Store Connect.
- Confirm price, display name, description, and localized metadata.
- Confirm App Store screenshots and review notes explain the premium model.
- Test the product in StoreKit local testing or sandbox.
- Confirm restore purchases works.
- Confirm cancelled, pending, unavailable, and offline product-loading states are acceptable.

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

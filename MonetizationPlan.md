# LexWriter Monetization Plan

App Name: LexWriter  
Date: 2026-09-04

## Recommended launch model

Launch with all documents unlocked in version 1.0, but keep the catalog split in code so payment can be turned on later without redesigning the app structure.

## Proposed free documents

- Purchase Agreement
- Receipt
- Loan Agreement

## Proposed premium documents

- Will
- Contract
- Power of Attorney
- Rental Agreement
- Cohabitation Agreement
- Debt Instrument
- Termination of Tenancy
- Employment Agreement
- NDA

## Why this split

- The free tier gives immediate practical value and is easy to demonstrate in screenshots.
- The premium tier contains broader legal value and more sensitive or higher-complexity templates.
- This supports a later move to `free app + in-app purchase` instead of converting the whole app to a paid-upfront product.

## Recommended next step

When you are ready to monetize, add:

1. A paywall screen.
2. A local feature flag that can disable premium document entry points.
3. StoreKit product identifiers and purchase restore flow.
4. Review text in App Store metadata that clearly explains what is included for free and what requires purchase.

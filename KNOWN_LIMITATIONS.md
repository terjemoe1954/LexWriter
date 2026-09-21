# LexWriter Known Limitations

Use this list for support replies, App Store review notes, release planning, and legal/product review.

For recurring user-facing replies, use `SUPPORT_RESPONSES.md`.

## Legal Scope

- LexWriter provides document templates and drafts, not legal advice.
- Users should review important or complex documents with a qualified adviser before signing.
- Higher-risk documents need extra caution, especially testament, debt instrument, power of attorney, employment agreement, and NDA.
- Templates may not cover unusual family, inheritance, business, international, or dispute situations.

## Data and Storage

- The app is designed around local entry, preview, printing, and PDF saving.
- The app does not currently provide a full document library, cloud sync, account system, or cross-device save flow.
- Users are responsible for storing printed or exported documents safely.

## Premium

- Premium badges are visible, but premium access is not enforced yet.
- Purchases are not available in the current version.
- The current free documents are purchase agreement, receipt, and loan agreement.
- The remaining document types are premium-marked but still available.
- Settings and Premium preview explain the current 3 free / 9 planned premium split.
- StoreKit product loading and purchase UI remain disabled until App Store Connect setup and testing are complete.
- The expected lifetime product identifier is `com.lexwriter.premium.lifetime`.

## Testing and Release

- Apple field-performance datasets were not available for live versions `1.0.1` or `1.0` when checked. Crash tooling did not resolve the product, so crash status should be checked manually in Xcode Organizer or App Store Connect.
- Unit tests currently cover the premium-preview state, premium safety flags/defaults, release/support/checklist premium-preparation wording, release checklist submission validation, release checklist product smoke-test scope, release checklist legal/trust review, release checklist App Store Connect checks, App Store release-notes premium-preparation scope, App Store metadata draft legal/print scope, App Store keyword scope, App Store review/screenshot scope, App Store screenshot checklist scope, UI test target application, support saving/print scope, support legal-advice scope, support privacy/local-processing scope, known-limitations release risks, premium activation preconditions and document split, version 1.1 premium deferral, handoff safe-session instructions, App Store milestone premium-readiness order and next build order, full PremiumView localization, supported languages and stable language identifiers, stable appearance identifiers, Home and Settings localization, stable document order/identifiers, distinct document titles/subtitles, document card titles/subtitles/icons, document checklist titles/items, document preview button labels, print-preview controls, validation and requirement messages, access-tier/monetization-plan consistency, printable HTML-preview/signature structure, home-screen legal-scope copy, Settings privacy copy, User Guide localization, and User Guide access/privacy/legal-scope copy.
- UI test target application now points to `LexWriter`, but UI tests have not been run in this batch.
- Some test runs may need to be repeated manually if Xcode reports tests as discovered but not run.
- Before enabling premium enforcement, purchase, restore, pending purchase, cancelled purchase, and unavailable-product states must be tested.

## Future Candidates

- Local document save/history.
- More export options.
- More robust legal review for high-risk templates.
- App Store metadata and screenshots tailored to the premium model.

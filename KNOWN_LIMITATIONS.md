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
- The current free documents are purchase agreement, receipt, and loan agreement.
- The remaining document types are premium-marked but still available.
- StoreKit product loading and purchase UI remain disabled until App Store Connect setup and testing are complete.
- The expected lifetime product identifier is `com.lexwriter.premium.lifetime`.

## Testing and Release

- Xcode field performance data was not available yet for live version `1.0.1` when checked.
- Some test runs may need to be repeated manually if Xcode reports tests as discovered but not run.
- Before enabling premium enforcement, purchase, restore, pending purchase, cancelled purchase, and unavailable-product states must be tested.

## Future Candidates

- Local document save/history.
- More export options.
- More robust legal review for high-risk templates.
- App Store metadata and screenshots tailored to the premium model.

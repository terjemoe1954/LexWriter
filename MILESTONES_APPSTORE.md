# LexWriter Milestones Toward App Store

Last updated: 2026-08-29

## Goal

Bring `LexWriter` from a functional document-drafting app to an App Store-ready product with acceptable legal clarity, stable UX, and operational readiness.

## Milestone 1: Core Product Completion

- Finalize the current six document types and review every field label, warning, and print layout.
- Make the home screen, settings, and all document flows consistent across Norwegian, English, and Thai.
- Add missing document-specific icons, polish spacing, and verify dark/light mode throughout the app.
- Ensure every document can be previewed and printed without layout breakage on iPhone and iPad.

## Milestone 2: Legal Quality Pass

- Review every template against current Norwegian legal requirements and standard market practice.
- Add clear disclaimers where a lawyer review is strongly recommended.
- Separate "general template" documents from "higher-risk" documents such as wills and debt instruments.
- Verify wording around witnesses, signatures, dates, and mandatory legal rules.

## Milestone 3: Product Safety and Trust

- Add a visible privacy statement explaining that sensitive data is not intended to be stored permanently.
- Add a help/user guide section for first-time users.
- Decide whether any local autosave should exist; if yes, define deletion and retention behavior explicitly.
- Review App Store policy risk around legal content, claims, and consumer expectations.

## Milestone 4: App Store Readiness

- Create app name, subtitle, keyword set, screenshots, and App Store description.
- Produce polished app icon variants and launch visuals.
- Add support email, privacy policy URL, and terms URL if required by distribution setup.
- Prepare localized metadata for at least Norwegian and English; Thai can follow if capacity allows.

## Milestone 5: Testing and Stability

- Add unit tests for validation rules in each document model.
- Add UI tests for the main flows: language selection, navigation, field entry, preview, and settings.
- Test printing and preview behavior on device, not only in simulator.
- Run through edge cases: empty fields, very long text, multilingual text, and unusual dates.

## Milestone 6: Release Preparation

- Set versioning, build numbering, signing, and archive workflow in Xcode.
- Validate bundle metadata, app category, permissions, and deployment target.
- Test on current iOS versions and at least one smaller and one larger device size.
- Prepare a first review submission with conservative marketing language.

## Recommended Next Build Order

1. Add validation tests for the three newest document types.
2. Review print layouts for long-form text and signature spacing.
3. Add privacy/disclaimer text in a more prominent place on the home screen or first launch.
4. Write App Store metadata draft and decide final positioning.
5. Do a full device test and archive build.

## Open Questions

- Should LexWriter focus only on Norwegian legal documents at launch?
- Should the app ship with all six document types, or start with a smaller, safer subset?
- Do you want local save/export later, or should the app stay print-first?
- Do you want a lawyer or legal reviewer involved before App Store submission?

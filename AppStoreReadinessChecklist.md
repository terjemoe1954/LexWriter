# App Store Readiness Checklist

Dato: 3. september 2026
App: LexWriter

## Kode og funksjon

- [x] Prosjektet bygger i Xcode
- [x] Dokumenter kan forhåndsvises
- [x] Dokumenter kan skrives ut
- [x] Dokumenter kan lagres som PDF
- [x] Språkvalg støtter norsk, engelsk og thai
- [x] Mørk modus er justert for dokumentforhåndsvisning

## Personvern og compliance

- [x] `PrivacyInfo.xcprivacy` er lagt inn i appen
- [x] `UserDefaults` er deklarert med reason `CA92.1`
- [ ] Bekreft i Xcode Privacy Report at ingen flere required-reason APIs brukes
- [ ] Bekreft i App Store Connect at Privacy Nutrition Labels stemmer
- [ ] Legg inn privacy policy URL i App Store Connect
- [ ] Avklar endelig aldersmerking i App Store Connect

## Metadata

- [ ] Appnavn, undertekst og beskrivelse er ferdigstilt
- [ ] Keywords er ferdigstilt
- [ ] Screenshots for iPhone er klare
- [ ] Minst ett screenshot viser mørk modus
- [ ] App Review Notes er lagt inn

## Kvalitet

- [x] Enhetstester finnes
- [x] UI-tester finnes
- [ ] Kjør alle tester lokalt før innsending
- [ ] Verifiser PDF-eksport på fysisk enhet
- [ ] Verifiser utskrift/print sheet på fysisk enhet
- [ ] Gjennomgå alle dokumenttyper manuelt

## App Review Notes

- [ ] Forklar at appen genererer dokumentmaler og hjelpemidler
- [ ] Forklar at appen ikke gir individuell juridisk rådgivning
- [ ] Beskriv hvor språkvalg, preview, print og PDF finnes

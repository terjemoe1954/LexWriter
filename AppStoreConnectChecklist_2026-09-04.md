# LexWriter App Store Connect Checklist

Dato: 2026-09-04  
App: LexWriter

## Før opplasting

- [ ] Bekreft at `Version` og `Build` i prosjektet er riktige for innsending.
- [ ] Test appen på nytt i `System`, `Light` og `Dark`.
- [ ] Test språkene `Norsk`, `English` og `Thai`.
- [ ] Test PDF-lagring og utskrift fra minst 3 dokumenttyper.
- [ ] Test premiumflyt i simulator:
  - [ ] `Lås premium-dokumenter` på
  - [ ] Trykk på et premium-dokument
  - [ ] Premiumvisning åpner
  - [ ] `Gjenopprett kjøp` reagerer uten krasj
- [ ] Kontroller at appen ikke har tomme skjermer, brutte knapper eller tekst som mangler oversettelse.
- [ ] Kontroller at supportlenke og personvernerklæring er klare.

## App Store Connect

- [ ] Opprett ny appversjon i App Store Connect.
- [ ] Legg inn appbeskrivelse, nøkkelord, support-URL og privacy policy-URL.
- [ ] Sett riktig kategori og eventuell sekundærkategori.
- [ ] Sett `Pricing and Availability`.
- [ ] Last opp screenshots for iPhone-størrelsene du skal støtte.
- [ ] Fyll ut `App Privacy` i tråd med faktisk oppførsel i appen og `PrivacyInfo.xcprivacy`.
- [ ] Fyll ut `Age Rating`.

## In-App Purchase

- [ ] Opprett produktet `com.lexwriter.premium.lifetime` som `Non-Consumable`.
- [ ] Legg inn visningsnavn og beskrivelse for premium.
- [ ] Sett prisnivå og tilgjengelighet.
- [ ] Kontroller at `Paid Apps Agreement`, bank og skatt er aktive.
- [ ] Legg produktet til appversjonen med `Add for Review` når det skal sendes inn.

## Review Notes

- [ ] Forklar kort at appen lager juridiske dokumentutkast og ikke gir juridisk rådgivning.
- [ ] Opplys at appen støtter `Norsk`, `English` og `Thai`.
- [ ] Opplys at premium testes via appens innebygde premiumflyt.
- [ ] Dersom premium fortsatt ikke skal være aktiv i produksjon: skriv det tydelig i review notes.

## Anbefalt valg nå

- [ ] Send inn `v1.0` som gratis app.
- [ ] Behold premium-koden i appen, men aktiver faktisk salg først når App Store Connect-produktet og testene er helt ferdige.
- [ ] Bruk `free app + lifetime unlock` senere, ikke betalt app-front.

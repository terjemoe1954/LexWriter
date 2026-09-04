# LexWriter: Go For Paid Version

Dato: 2026-09-04  
Status: Start denne planen etter at gratisversjonen er godkjent og publisert.

## Mål

Gå fra gratis lansering til en stabil premiumversjon med `free app + lifetime unlock`, uten å skape unødvendig risiko i App Review eller for eksisterende brukere.

## Fase 1: Rett etter godkjenning

- [ ] Bekreft at gratisversjonen er live i App Store.
- [ ] Kontroller at metadata, screenshots og privacy-informasjon vises riktig i App Store.
- [ ] Følg med på første brukerfeedback, krasj og eventuelle supporthenvendelser.
- [ ] Ikke aktiver betaling før gratisversjonen er bekreftet stabil.

## Fase 2: Klargjør premium i App Store Connect

- [ ] Opprett `Non-Consumable` In-App Purchase.
- [ ] Produkt-ID: `com.lexwriter.premium.lifetime`
- [ ] Legg inn navn, beskrivelse, pris og tilgjengelighet.
- [ ] Sørg for at `Paid Apps Agreement`, bank og skatt er aktive.
- [ ] Forbered review-notes som forklarer hva premium låser opp.

## Fase 3: Slå på premium i appen

- [ ] Sett premium-låsing aktiv i kodebasen.
- [ ] Slå på premium-badger hvis du vil synliggjøre forskjellen i dokumentlisten.
- [ ] Vurder om `Premium testing` fortsatt skal være skjult i release-build.
- [ ] Test flyten:
- [ ] gratis dokument åpner normalt
- [ ] premium dokument åpner paywall
- [ ] kjøp gir tilgang
- [ ] restore fungerer
- [ ] tilgang beholdes etter ny appstart

## Fase 4: Oppdater App Store-innhold

- [ ] Oppdater appbeskrivelse med gratis/premium-modellen.
- [ ] Forklar tydelig hvilke dokumenter som er gratis.
- [ ] Forklar tydelig hva premium låser opp.
- [ ] Oppdater screenshots hvis premium skal vises i UI.
- [ ] Oppdater review notes for ny versjon.

## Fase 5: Kvalitet før innsending

- [ ] Test på fysisk iPhone.
- [ ] Test på simulator.
- [ ] Test `Norsk`, `English` og `Thai`.
- [ ] Test `System`, `Light` og `Dark`.
- [ ] Test PDF-lagring og utskrift fortsatt etter premium-endringer.
- [ ] Kontroller at ingen gratisdokumenter feilaktig er låst.

## Anbefalt gratis/premium-splitt

### Gratis

- Purchase Agreement
- Receipt
- Loan Agreement

### Premium

- Will
- Contract
- Power of Attorney
- Rental Agreement
- Cohabitation Agreement
- Debt Instrument
- Termination of Tenancy
- Employment Agreement
- NDA

## Viktige beslutninger

- [ ] Bestem endelig pris for livstidstilgang.
- [ ] Bestem om premium skal vises i UI med en gang eller først når IAP er godkjent.
- [ ] Bestem om første premiumversjon skal sendes kort tid etter gratislansering eller etter en kort stabiliseringsperiode.

## Ferdig når

- [ ] IAP er opprettet i App Store Connect.
- [ ] Premiumflyten fungerer i test.
- [ ] Metadata er oppdatert.
- [ ] Ny build er lastet opp.
- [ ] Review notes er klare.
- [ ] Versjonen er sendt inn.

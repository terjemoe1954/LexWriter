# LexWriter – testplan for forbedringsarbeidet

Sist oppdatert: 15. oktober 2026

## Testdata og isolasjon

- Bruk simulator med `-resetUITestState` og kun tydelig fiktive personer, for eksempel Kari Eksempel og Ola Eksempel.
- Ikke nullstill eller importer brukerens lagring. Appen har per M0 ingen dokumentdatabase/iCloud-synk, men dette må kartlegges på nytt hvis lagring innføres.
- Eksporter test-PDF til et eget testområde. Ikke legg testdokumenter med personopplysninger i git.
- Fremtidig migrering skal testes på kopi av eldre data før en utgivelse.

## Automatiserte kontroller

| Område | Kontroll | Status 15.10.2026 |
|---|---|---|
| Build | Bygg aktiv app-scheme | Bestått før flaggretting; målrettede tester bygget etter retting |
| Premiumsikkerhet | Badges på, StoreKit av, håndheving av | Bestått |
| Dokumenttilgang | Eksakt 3 gratis / 9 premiummerkede dokumenter | Bestått |
| Kjøpsstatus | Premiumvisning forklarer at alle dokumenter er åpne | Bestått |
| Kvittering | Påkrevde felt og rådgivende advarsler | Bestått |
| Kvittering | Ny veiledning og eksempler finnes på norsk, engelsk og thai | Bestått |
| Kvittering-kladd | Lagre, laste og slette full kladd uten å endre premiumstatus | Bestått |
| Kvittering / M5 | Alle dokumentfelter havner i forventet tekst; tomme valgfrie felt får ryddig standardtekst | Bestått |
| Kvittering / M7 | Norsk, engelsk og thai, kladdrundtur, feltkobling og deaktivert premiumhåndheving | Bestått, 5 av 5 målrettede tester |
| Tilgangsmodell | Gratis/premium-oppførsel i `PurchaseManager` | Bestått |

M0/M1-kjøring: 5 av 5 målrettede tester besto. Etter pilotendringen besto ytterligere 3 av 3 målrettede tester, inkludert lokaliseringsdekning. Full enhets- og UI-testsuite er ikke kjørt i denne runden.

## Manuelle M1-scenarier

| Scenario | Forventet | Resultat |
|---|---|---|
| Start med tom testtilstand | Hjem forklarer formål og juridisk avgrensning | Bestått |
| Åpne premiummerket dokument | Dokumentet åpnes uten kjøp så lenge premium er deaktivert | Bestått for Kontrakt og NDA |
| Åpne Kvittering | Roller, betalingsdetaljer og vei til forhåndsvisning er synlig | Bestått |
| Ny pilotveiledning | «Før du begynner», tre veiledningspunkter og fiktive eksempler vises uten tydelig klipping | Bestått på 402 × 874 simulator |
| Vedvarende etikett | Etikett og påkrevd-status forblir synlig etter inntasting | Bestått med fiktivt navn |
| Trykk forhåndsvisning med tomt skjema | Konkrete krav vises og ingen data forsvinner | Krav vist; ingen data var skrevet |
| Skriv fiktivt navn, gå tilbake og åpne igjen | Kvittering-kladden gjenopprettes | Ikke testet manuelt etter M4-endringen; lagringsrundtur består i enhetstest |
| Omstart med delvis utfylling | Kvittering-kladden gjenopprettes | Ikke testet manuelt etter M4-endringen; lagringsrundtur består i enhetstest |
| Tastatur og alle datatyper | Riktig tastatur, ingen tildekking eller fastlåst fokus | Delvis: telefon/e-post er konfigurert; full UI-test gjenstår |
| Visuelt eksportert PDF og fysisk AirPrint | Riktig innhold, tegnsett, sideskift og signaturfelt | Ikke testet i M1 |

## Neste nødvendige teststeg for piloten

1. Avklar de fire åpne feltspørsmålene i `LEXWRITER_FELTGJENNOMGANG.md` før dokumentmalen endres.
2. Test en liten løsning for vedvarende etiketter, forklaringer og eksempler i Kvittering.
3. Legg regresjonstester for felt-til-dokument-kobling, beløp/valuta, betalingsdato og tomme valgfrie felt.
4. Hvis utkastlagring innføres: test tilbake, bakgrunn, tvungen avslutning, omstart og oppgradering fra eldre build på kopi.
5. Kontroller forhåndsvisning og eksportert PDF visuelt på liten iPhone, stor iPhone og iPad før mønsteret rulles ut til andre dokumenttyper.

## M4-status for Kvittering

En lokal, versjonert kladd er implementert med automatisk lagring, gjenopprettingsmelding og bekreftet «Slett kladd»-handling. Enhetstesten bekrefter rundtur av alle felt, sletting, at tomt skjema ikke lagres, og at premiumstatus ikke endres. Simulatoren bygget og startet, men interaksjonsrunden ble avbrutt før tilbake/gjenåpning, relansering og sletteknappen ble observert. Disse står derfor fortsatt som ikke testet manuelt.

## M5-status for Kvittering

Automatisert felt-til-dokument-kontroll består, inkludert tom betalingsmåte og merknad. HTML-escaping dekkes av eksisterende test. Omfanget mot bokførings-/MVA-pliktig salgsdokumentasjon er kontrollert mot Lovdata og Skatteetaten og forklart i skjemaet. Visuell sammenligning av forhåndsvisning og eksportert PDF, signaturspørsmålet og om telefon/e-post skal inn i dokumentet gjenstår.

Omfangsadvarselen er manuelt kontrollert på 402 × 874-simulator: hele teksten vises uten tydelig klipping eller overlapping.

## M6-status for Kvittering

Fire av fire målrettede tester består for lokalisert eksporttekst, feltinnhold, tomme valgfrie felt, filnavn og fortsatt deaktivert premiumhåndheving. PDF-koordinatoren rapporterer nå skrive-/presentasjonsfeil, og Kvittering viser en lokalisert feil.

Simulator på 402 × 874 åpnet Kvittering og tok imot langt fiktivt utstedernavn og adresse. Tastatur/scroll-reflow blokkerte testautomatiseringens neste treffpunkt, så komplett utfylling, forhåndsvisning, PDF-dialog, eksportert PDF og utskriftsdialog er ikke testet. Dette er ikke registrert som en bekreftet appfeil uten manuell reproduksjon. Fysisk AirPrint gjenstår.

## M7-status for Kvittering

Kildeaudit etter retting gir PASS for Dynamic Type og VoiceOver i pilotfeltene og dokumentforhåndsvisningen. Faste 30/18-punkts skrifter er erstattet med skalerende tekststiler, feltetikett og kravmerke faller tilbake til vertikal layout når bredden ikke holder, og VoiceOver får én tydelig feltetikett med krav og eksempel som hint.

Kontrast mot papirbakgrunnen er beregnet til 13,3:1 for hovedtekst, 6,6:1 for sekundærtekst og 4,0:1 for kanten; dette består relevante WCAG 2.1-krav. Xcode-bygg består uten feil. Fem målrettede regresjonstester består for alle tre språk, dokumentfelt, kladd og fortsatt deaktivert premiumhåndheving.

Simulator på iPhone 17 Pro viser Kvittering uten observert klipping eller overlapp. Skjemaet kan rulles, felt og påkrevd/valgfritt-markører finnes i tilgjengelighetshierarkiet, og norsk, engelsk og thai bryter lange tekster korrekt. Ingen krasj ble observert. Største Dynamic Type kunne ikke aktiveres med de tilgjengelige enhetsverktøyene.

Manuell kontroll med største tekststørrelse, faktisk VoiceOver-leserekkefølge, tastatur, lyst/mørkt/systemutseende og full flyt på fysisk iPhone gjenstår. Eksisterende dokumentinnhold, lagringsformat og tilgangsgrenser er ikke endret.

Eier rapporterte deretter fullførte tester på iPhone 17 Pro-simulator og at dokumentene ble lagret lokalt. Dette registreres som bestått manuell simulatorverifikasjon av lokal lagring. Det er ikke det samme som verifikasjon på fysisk iPhone, ekstern PDF-destinasjon, AirPrint eller tre uavhengige førstegangsbrukere.

Tre førstegangsbrukere har senere fullført Kvittering. Ett funn var at Tab fra Merknader ikke flyttet fokus videre. Etter retting bekreftet eier manuelt at Tab flytter fokus til neste felt, Sted. Build består. De fire tidligere avbrutte regresjonstestene ble kjørt på nytt i M10: 4 av 4 besto for språk/veiledning, kladd, feltkobling og deaktivert premiumhåndheving.

## M10-status

Aktiv scheme bygger uten feil. Hele enhetstestsuiten består med 94 av 94 tester. Alle 7 ordinære UI-tester består, inkludert hjem, språk, innstillinger, premiumvisning, brukerveiledning og åpning av Testament. Oppstartstesten består separat, 1 av 1. Enhetstestene inkluderer Kvitteringens språk/veiledning, kladd, feltkobling, premiumvern og en ny oppgraderingskontroll som bekrefter at en eldre installasjon uten Kvittering-kladd beholder eksisterende innstillinger og premiumstatus. Tab-rettingen er manuelt bekreftet, utgivelsesnotatene beskriver de faktiske endringene, og et avgrenset TestFlight-opplegg ligger i `TESTFLIGHT_INSTRUKSJONER.md`.

Versjon 1.1, build 6 ble bekreftet av eier og testet på en fysisk iPhone 15 Pro med iOS 27.0.1. Eier bekreftet at appen installeres og starter på enheten etter at en tidligere TestFlight-versjon ble avinstallert.

Et iOS App Archive for versjon 1.1, build 6 er opprettet og kontrollert visuelt i Xcode Organizer. Arkivet har bestått alle valideringskontroller, er lastet opp til App Store Connect og er testet internt via TestFlight. Eier rapporterte 18. oktober 2026 at appen ser bra ut etter flere dagers bruk, uten nye feil. Publisering er ikke utført. Reell oppgradering med kopi av data fra en installert eldre build, fysisk AirPrint, største Dynamic Type/VoiceOver og full visuell PDF-sammenligning på liten iPhone, stor iPhone og iPad gjenstår.

Ved gjennomgang av markedsføringsmaterialet 18. oktober viste eksportert norsk Kvittering signeringsdatoen som «18 October 2026». Datoformatet er rettet til å følge valgt dokumentspråk, og buildnummeret er økt til 7. Ny regresjonstest består for norsk, engelsk og thai, og prosjektet bygger uten feil. Eier eksporterte deretter en ny norsk PDF som korrekt viser «Oslo, 18. oktober 2026». Build 7 er arkivert, validert uten feil og lastet opp til App Store Connect. Build 6 skal ikke sendes til gjennomgang.

Ved full testplan etter rettelsen besto 71 tester, inkludert den nye språkregresjonen. 24 dokumentasjonstester feilet fordi simulatorprosessen ikke fikk åpnet eksisterende Markdown-filer på verts-Macen, og 8 UI-tester ble ikke kjørt i den kombinerte runden. Dette er registrert som et testmiljøproblem, ikke som beståtte tester eller en bekreftet appfeil.

App Store-skjermbildene avdekket deretter at norsk DatePicker fortsatt viste «18 Oct 2026» selv om PDF-en var rettet. DatePicker bruker nå eksplisitt `nb_NO`, `en_GB` eller `th_TH` fra valgt appspråk. Build for testing og målrettet regresjonstest består. Eier bekreftet manuelt at build 8 viser «18. okt. 2026» i skjemaet og «18. oktober 2026» i PDF-en. Build 7 skal ikke sendes til gjennomgang; build 8 er gjeldende kandidat.

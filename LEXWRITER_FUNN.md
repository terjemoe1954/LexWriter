# LexWriter – funn fra M0 og M1

Sist oppdatert: 18. oktober 2026

## Prioritert funnliste

| ID | Skjerm/dokumenttype | Observasjon eller reproduksjon | Konsekvens | Prioritet | Foreslått løsning | Status | Testresultat |
|---|---|---|---|---|---|---|---|
| LW-001 | Tilgang og kjøp | `isPremiumStoreEnabled` og `enforcesPremiumAccess` var `true`, i strid med prosjektinstruksene om å holde alle dokumenter åpne. | Premiummerkede dokumenter kunne bli låst, og StoreKit kunne starte uten ferdig kjøpsoppsett. | P0 | Sett begge flagg til `false` og behold eksisterende produkt-ID og tilgangsdata. | Rettet | Build besto. Fem målrettede tester besto. Simulator åpnet Kontrakt og NDA uten betalingsdialog. |
| LW-002 | Kvittering og øvrige redigeringsskjemaer | Skriv «Kari Eksempel» i utsteders navn, gå tilbake og åpne Kvittering igjen. Feltet var tomt i M1. | Brukeren mister utfylling ved avbrudd eller feil navigasjon. | P1 | Innfør isolert, versjonert kladdlagring i piloten før et felles mønster vurderes. | Implementert for Kvittering; manuell flyt gjenstår | Automatisk rundtur/sletting og isolasjon fra kjøpsstatus er testet. Tilbake/omstart/sletteknapp ble ikke fullført manuelt. |
| LW-003 | Hjem / premiummerkede dokumenter | Kortene sier «Premium», men dokumentene er åpne og ingen forklaring på hjemskjermen sier at kjøp ikke er nødvendig i denne versjonen. | Førstegangsbrukeren kan tro at dokumentene er låst eller at betaling kommer etter utfylling. | P2 | Vis kort, lokal forklaring ved seksjonen eller bruk en mer presis midlertidig merking så lenge kjøp er deaktivert. | Bekreftet, åpen | Bekreftet i simulator; Kontrakt og NDA åpnet direkte. |
| LW-004 | Alle skjemaer | De fleste felt bruker `TextField`-prompten som eneste synlige felttekst. Når brukeren skriver, forsvinner teksten. | Rollen, betydningen og forventet format blir vanskeligere å huske under utfylling. | P2 | Piloter vedvarende etikett, kort forklaring og fiktivt eksempel i Kvittering før mønsteret vurderes for andre skjemaer. | Rettet i Kvittering; øvrige dokumenter åpne | Kvittering har nå vedvarende etiketter, påkrevd/valgfritt og lokaliserte eksempler. |
| LW-005 | Kvittering | Beløp og betalingsdato er fritekst uten synlig format- eller valutaeksempel. | Ulikt format kan gi uklart dokument og mer valideringsarbeid. | P2 | Forklar valuta og datoformat; vurder egnet tastatur/datokontroll uten å endre dokumentbetydningen. | Delvis rettet | Eksempler viser valuta og datoformat; beløp bruker tall-/tegn-tastatur. Feltformat valideres fortsatt ikke. |
| LW-006 | Hjem / dokumentvalg | Kortene har konkrete undertitler, men brukeren kan ikke se anonymt ferdigdokument eller nødvendige opplysninger før skjemaet åpnes. | Valg og forberedelse krever prøving og tilbake-navigasjon. | P2 | Start med en kort «Dette trenger du» og anonym forhåndsvisning for piloten. | Bekreftet, åpen | Kode og simulator. |
| LW-007 | Validering i skjemaene | Advarsler vises øverst før brukeren har skrevet, mens blokkerende krav først vises etter trykk på forhåndsvisning. | Skjermen kan virke problemorientert ved åpning, og feil er ikke knyttet direkte til feltet. | P2 | Vis veiledning før feil, og legg konkrete feil ved relevant felt etter forsøk på forhåndsvisning. | Bekreftet i Kvittering, åpen | Simulator viste advarsler ved åpning og blokkerende krav etter «Vis kvittering». |
| LW-008 | Dokumentversjon og jurisdiksjon | Ferdige dokumenter lagres ikke i appen, og modellene har ingen malversjon. Språkvalg styrer dokumenttekst, mens flere maler bruker norsk rett i standardtekst. | Det finnes ingen intern historikk som fryser tidligere malinnhold; språk kan forveksles med lovvalg. | P2 | Dokumenter jurisdiksjon og malversjon før maltekst endres. Ikke påstå at grensesnittspråk endrer lovvalg. | Bekreftet i kode, åpen | Ingen SwiftData/Core Data/CloudKit/dokumentlager eller malversjonsfelt funnet. |
| LW-009 | PDF-eksport | PDF ble skrevet til midlertidig mappe med `try?`, slik at skrivefeil kunne bli ignorert. | Eksport kunne mislykkes uten tydelig feilmelding. | P2 | Returner eksportresultat og vis forståelig feil i piloten. | Rettet for Kvittering; øvrige dokumenter åpne | Koordinatoren returnerer nå feilstatus; Kvittering viser lokalisert feil. Feiltilstanden er ikke fremprovosert manuelt. |
| LW-010 | Kvittering / juridisk omfang | Malen mangler flere opplysninger som kreves når en bokføringspliktig virksomhet bruker et dokument som salgsdokumentasjon, blant annet dokumentnummer, organisasjonsnummer og eventuell MVA-spesifikasjon. | En bruker kan feilaktig bruke den enkle betalingsbekreftelsen som næringsbilag. | P1 | Avgrens malen tydelig mot bokførings-/MVA-pliktig salgsdokumentasjon. Ikke bygg bedriftskvittering uten egen kravgjennomgang. | Avgrensning rettet; funksjonsgap åpent | Omfangsadvarsel lagt til på norsk, engelsk og thai. Primærkilder kontrollert 15.10.2026. |
| LW-011 | Kvittering / forhåndsvisning og PDF | Norsk Kvittering viste signeringsdatoen som «18 October 2026» fordi datoformatet fulgte enhetens region i stedet for valgt dokumentspråk. | Dokumentet blandet norsk og engelsk og var uegnet som endelig App Store-eksempel. | P1 | Formater signeringsdato eksplisitt med norsk, engelsk eller thai locale basert på valgt språk. | Rettet | Regresjonstest består for «oktober», «October» og «ตุลาคม». Full Xcode-build består. Eier eksporterte deretter ny norsk PDF som korrekt viser «Oslo, 18. oktober 2026». |
| LW-012 | Kvittering / datovelger | Norsk skjema viste den valgte signeringsdatoen som «18 Oct 2026» fordi systemets DatePicker ikke fikk appens valgte locale. | Norsk grensesnitt blandet norsk og engelsk, og skjermbildet kunne ikke brukes i App Store. | P1 | Gi DatePicker eksplisitt locale fra valgt appspråk. | Rettet | Build for testing og språkregresjon består. Eier bekreftet manuelt at build 8 viser «18. okt. 2026» i skjemaet og «18. oktober 2026» i PDF-en. |

## M0 – faktisk funksjonsoversikt

- Appversjon/build: 1.0.5 (5).
- Plattform: iOS/iPadOS, iPhone og iPad (`TARGETED_DEVICE_FAMILY` 1,2), minimum iOS 26.5.
- Språk: norsk, engelsk og thai. Språk og utseende lagres i `UserDefaults` via `@AppStorage`.
- Dokumenter: Testament, Kontrakt, Fullmakt, Husleiekontrakt, Samboeravtale, Gjeldsbrev, Kjøpskontrakt, Oppsigelse av leieforhold, Kvittering, Låneavtale, Arbeidsavtale og NDA.
- Tilgang: Kjøpskontrakt, Kvittering og Låneavtale er merket Gratis. Ni andre er merket Premium, men skal være åpne. StoreKit-lasting og håndheving er nå deaktivert igjen.
- Redigering: Hvert dokument har en egen SwiftUI `Form` med lokal `@State`-modell, sjekkliste, advarsler, validering og forhåndsvisningsark.
- Lagring/synk: Ingen dokumentdatabase, dokumentbibliotek, konto, CloudKit eller iCloud-synk ble funnet. M4-piloten lagrer nå én lokal, versjonert Kvittering-kladd i `UserDefaults`; språk, utseende og premiumstatus bruker separate nøkler.
- Maltekst: Ligger i Swift-modellene som ren tekst og HTML. Lokalisering ligger i `AppLocalization.swift`, `DocumentLocalization.swift` og dokumentmodellene. Ingen malversjon ble funnet.
- Forhåndsvisning/utdata: HTML vises i en papirvisning. Utskrift bruker systemets `UIPrintInteractionController`. PDF genereres som A4 til midlertidig fil og eksporteres med dokumentvelger.
- Hovedflyt: Start → velg dokumentkort → fyll ut skjema → trykk forhåndsvisning → velg dokumentspråk → kontroller → skriv ut eller lagre PDF.
- Sikker testtilstand: Simulator ble startet med `-resetUITestState` og kun fiktivt navn. Det finnes ingen dokumentdatabase eller iCloud-container å koble fra. Brukerens lokale dokumenter ble ikke åpnet eller nullstilt.
- Backup/gjenoppretting: Appen har ingen dokumentbackup eller dokumenthistorikk. Kvittering-kladden kan gjenopprettes lokalt, men er ikke et ferdigstilt dokument. Eksporterte PDF-er forvaltes av brukerens valgte lagringssted.

## M1 – pilotvalg

**Pilot: Kvittering.** Den har et vanlig og tydelig brukerbehov, er gratis, er mindre juridisk kompleks enn testament/fullmakt/arbeidsavtale og lar oss kontrollere direkte at parter, beløp, dato, formål og betalingsmåte havner riktig i resultatet.

Simulatorgjennomgangen bekreftet tydelig startside, juridisk ansvarsmerknad, fungerende navigasjon, relevante kvitteringsfelt og deaktivert forhåndsvisning med konkrete krav. Den bekreftet også LW-002, LW-003, LW-005 og LW-007. Ingen krasj eller åpenbare overlapp ble observert. Tastaturvarianter, bakgrunn/gjenopptakelse, fysisk utskrift og visuelt eksportert PDF-resultat er ikke testet i M1.

## M5 – kontrollert omfang for Kvittering

Felt-til-dokument-koblingen er testet for begge parters navn/adresse, betalingsformål, beløp, betalingsdato, betalingsmåte, referanse, signeringssted og signaturnavn. Tom betalingsmåte og merknad gir eksplisitt standardtekst, ikke tomme avsnitt. Telefon og e-post samles inn, men vises ikke i dokumentet; dette forblir et åpent produktspørsmål. Selve signaturvalget er heller ikke endret.

Offentlige kilder kontrollert 15. oktober 2026:

- [Bokføringsforskriften – dokumentasjon av salg og kjøp](https://lovdata.no/forskrift/2004-12-01-1558/%C2%A78-9)
- [Skatteetaten – krav til angivelse av partene i salgsdokumentet](https://www.skatteetaten.no/rettskilder/type/uttalelser/prinsipputtalelser/krav-til-angivelse-av-partene-i-salgsdokumentet/)
- [Bokføringsloven § 10 og § 10 a](https://lovdata.no/lov/2004-11-19-73)

Kildene gjelder bokførings-/avgiftspliktig salgsdokumentasjon. De dokumenterer ikke et generelt formkrav for enhver privat betalingsbekreftelse. Derfor er piloten avgrenset som enkel betalingsbekreftelse og ikke utvidet til bedriftskvittering.

## M6 – PDF og utskrift for Kvittering

- PDF-skrivefeil ignoreres ikke lenger av koordinatoren. Kvittering viser en lokalisert feilmelding hvis filen ikke kan klargjøres eller dokumentvelgeren ikke kan presenteres.
- Filnavnet følger valgt dokumentspråk, for eksempel `Kvittering.pdf` eller `Receipt.pdf`, og saniteres uten personopplysninger.
- HTML-malen bruker A4-størrelse, 36 punkters utskriftsmarg, `overflow-wrap: anywhere` og sidebruddsbeskyttelse rundt signaturdelen.
- Målrettede tester bekrefter feltinnhold, tomme valgfrie felt og lesbare filnavn.
- Simulatoren tok imot langt fiktivt navn og adresse i skjemaet, men automatisert videre utfylling ble blokkert av tastatur/scroll-reflow. Forhåndsvisning, eksportert PDF, systemets PDF-dialog og utskriftsdialog er derfor fortsatt **ikke visuelt testet** i denne M6-runden. Fysisk AirPrint er heller ikke testet.

# LexWriter – enklere dokumenter, tydelig veiledning og bedre synlighet

Opprettet: 15. oktober 2026
Status: M0 kartlagt, M1 pilot valgt og førstegangsgjennomgang gjennomført 15. oktober 2026

## Målet

Gjøre den eksisterende LexWriter-appen enklere å forstå for mennesker som trenger et dokument, men ikke kjenner alle begrepene. Brukeren skal forstå hva appen gjør, velge riktig dokument, vite hva som skal stå i feltene og få en lesbar PDF med tydelige neste steg. Deretter skal den norske App Store-presentasjonen vise den samme nytten med ekte eksempler.

Appen skal bli bedre på sine eksisterende hovedoppgaver før nye dokumenttyper legges til. Flere nedlastinger eller kjøp kan ikke garanteres; planen skal gjøre nytten lettere å oppdage og dokumentflyten lettere å fullføre.

## Grunnlaget for denne planen

Eieren ønsker særlig bedre feltforklaringer og en tydeligere presentasjon. Selve kildekoden, nåværende skjemaer og App Store-siden er ikke gjennomgått ved opprettelse av planen. Dokumenttyper, mangler og funksjoner nedenfor er derfor kontrollpunkter, ikke bekreftede funn. Eksempler på felt er illustrasjoner og må tilpasses malene som faktisk finnes.

## Oppdrag til Codex i LexWriter-prosjektet

Les AGENTS.md, tidligere milepæler og prosjektets dokumentasjon. Kartlegg den faktiske appen først. Ikke start et nytt prosjekt eller erstatt fungerende løsninger uten grunn. Gjennomfør milepælene i rekkefølge med små, testbare endringer og oppdater denne filen etter hvert.

Start med M0 og M1. Lag en prioritert funnliste og velg én representativ dokumentflyt som pilot. Forbedre og test piloten før felles mønstre brukes på de andre dokumenttypene. Fortsett med gjennomførbare oppgaver innenfor planen; spør bare når en avgjørelse krever eierens kunnskap, endrer dokumentets rettslige betydning eller påvirker eksisterende data og kjøpsrettigheter.

### Arbeidsregler

- Bevar eksisterende dokumenter, utkast, innstillinger og kjøpsrettigheter. Ikke nullstill brukerens lagring for å løse testproblemer.
- Test med separat database og tydelig fiktive personer. Ikke bruk kundedata eller personlige dokumenter i logger, git, markedsføring eller testskjermbilder.
- Kartlegg eventuell iCloud-synk før testing; simulator med samme konto og container er ikke nødvendigvis isolert fra ekte data.
- Bevar brukerens uferdige kodeendringer. Dokumenter nødvendige modellendringer og test migrering på kopi.
- Skill forbedring av språk og skjema fra endring av juridiske maler. Enklere ord skal ikke umerkelig endre dokumentets betydning.
- Ikke markedsfør automatisk juridisk gyldighet, advokatgodkjenning eller dekning av alle situasjoner uten dokumentert grunnlag.
- Ikke legg inn AI, ny server, nye dokumenttyper eller ny prismodell som standard del av arbeidet.
- Ikke påstå at en kontroll er bestått uten å ha utført den. Registrer «ikke testet» med konkrete teststeg hvis miljøet mangler Xcode, enhet eller skriver.
- Klargjør endringer og presentasjonsmateriale lokalt. Opplasting til TestFlight, endringer i App Store Connect og publisering gjøres senere i eierens utgivelsesløp.

## Dokumentasjon og prioritering

Opprett disse arbeidsfilene i prosjektets eksisterende dokumentasjonsmappe:

1. `LEXWRITER_FUNN.md`: bekreftede feil, forståelsesproblemer, forbedringsforslag og testresultater.
2. `LEXWRITER_FELTGJENNOMGANG.md`: gjennomgang av hvert felt i hver dokumenttype.
3. `LEXWRITER_TESTPLAN.md`: automatiserte kontroller, manuelle scenarier og eierens teststeg.
4. `LEXWRITER_APPSTORE_NO.md`: forslag til norsk presentasjon, skjermbildeplan og måleplan etter at funksjonene er verifisert.

| Prioritet | Eksempel | Tiltak |
|---|---|---|
| P0 | Tap av dokumenter, feil part/beløp eller alvorlig feil i generert innhold | Rett før videre forbedring |
| P1 | Krasj, feil dokumentmal, tap av utfylling eller eksport som ikke virker | Rett før utgivelse |
| P2 | Brukeren forstår ikke et felt, mangler relevant veiledning eller finner ikke utskrift | Prioriter i denne gjennomgangen |
| P3 | Kosmetikk eller større valgfrie funksjoner | Vurder etter dokumentert nytte |

Hvert funn skal inneholde ID, berørt skjerm/dokumenttype, reproduksjonssteg eller observasjon, konsekvens, prioritet, foreslått løsning, status og testresultat. Ikke registrer en antatt mangel som en bekreftet feil.

## M0 – kartlegg dagens app og beskytt data

Resultat 15. oktober 2026: Faktisk funksjonsoversikt, lagring, kjøpsflyt, malplassering, versjon og plattformer er dokumentert i `LEXWRITER_FUNN.md`. Isolert simulator med fiktive data ble brukt. Et P0-avvik som aktiverte StoreKit og premiumhåndheving ble rettet; eksisterende produkt-ID og lagret kjøpsstatus ble ikke endret. Appen har ingen intern dokumentlagring, synk eller malversjon å migrere i dagens løsning.

- [ ] Les prosjektregler, tidligere planer og dokumentasjon. Noter versjon/build og støttede plattformer.
- [ ] Bygg dagens prosjekt og registrer eksisterende feil og relevante advarsler.
- [ ] Lag oversikt over dokumenttyper, målgrupper, tilgjengelige språk og land/jurisdiksjon per mal.
- [ ] Kartlegg skjemaer, lagring, utkast, eventuell synk, forhåndsvisning, PDF, utskrift og kjøpsflyt.
- [ ] Avklar hvor maltekst, hjelpetekster og lokalisering ligger, og om disse har versjonsinformasjon.
- [ ] Kontroller om gamle dokumenter bruker en lagret malversjon eller endres når appens mal oppdateres.
- [ ] Etabler separate testdata og noter tilgjengelig backup og gjenoppretting.
- [ ] Beskriv dagens hovedflyt fra åpning av appen til dokumentet er skrevet ut eller delt.

Ferdig når: Funksjonsoversikten er basert på faktisk kode, og testingen er adskilt fra brukerens dokumenter.

## M1 – forstå appen som en førstegangsbruker

Resultat 15. oktober 2026: Kvittering er valgt som pilot. Førstegangsbrukerflyten er gjennomgått i isolert simulator og funn er prioritert i `LEXWRITER_FUNN.md`. Delvis utfylling går tapt ved tilbake/gjenåpning (P1), og premiummerkingen er uklar når alle dokumenter er åpne (P2). Full tastaturmatrise, omstart med utfylling, fysisk utskrift og visuelt eksportert PDF-resultat gjenstår i senere milepæler.

- [ ] Gjennomgå appen med tom lagring og uten forkunnskaper om faguttrykk.
- [ ] Undersøk om første skjerm forklarer hva man kan lage og viser en tydelig vei videre.
- [ ] Kontroller om dokumentvalgene beskriver situasjonen brukeren står i, ikke bare dokumentets formelle navn.
- [ ] Undersøk om brukeren kan se hva et eksempel på ferdig dokument inneholder før større utfylling.
- [ ] Kontroller om krav til betaling og eventuelle begrensninger er forståelige før brukeren investerer mye tid.
- [ ] Følg én faktisk dokumenttype fra valg til PDF, og noter alle steder der brukeren kan bli usikker.
- [ ] Test tilbake, avbryt, tastatur, gjenåpning av utkast og gjenopptakelse etter omstart.
- [ ] Velg pilot ut fra tydelig brukerbehov, eksisterende funksjonalitet og mulighet til å verifisere resultatet. Ikke velg automatisk den juridisk mest kompliserte malen.

Ferdig når: Piloten er valgt, og funnlisten skiller bekreftede tekniske feil fra språk- og forståelsesproblemer.

## M2 – gjør dokumentvalget forståelig

Pilotstatus 15. oktober 2026: Kvittering forklarer nå hva dokumentet brukes til, hvilke opplysninger brukeren bør ha klare, hva resultatet kan brukes til og at utfyllingen ikke lagres som utkast. Endringen er lokalisert til norsk, engelsk og thai. Hjemmekortet og øvrige dokumenttyper er ikke endret i denne piloten.

For hver eksisterende dokumenttype skal brukeren kunne finne korte svar på:

- Hva brukes dokumentet til?
- Hvem passer det for, og i hvilke vanlige situasjoner?
- Hvilke opplysninger bør jeg ha klare?
- Hvilket land eller regelverk er malen laget for, hvis relevant?
- Hva får jeg til slutt, og hvilke steg kan gjenstå etter eksport?
- Når passer ikke denne standardmalen, eller når bør jeg få faglig hjelp?

Oppgavene er:

- [ ] Bruk korte, konkrete beskrivelser basert på malenes faktiske bruksområde.
- [ ] Gjør «Nytt dokument» og «Mine utkast/dokumenter» lette å skille hvis begge finnes.
- [ ] Vis et anonymt eksempel eller en forhåndsvisning der det hjelper brukeren å velge.
- [ ] Behold dokumentenes korrekte navn, men forklar fagord i vanlig språk.
- [ ] Vis relevant veiledning der den trengs; unngå lange introduksjoner som må leses før hver bruk.
- [ ] Ikke vis dokumenttyper som appen ikke faktisk støtter.

Ferdig når: En ny bruker kan forklare hva piloten brukes til og hvilke opplysninger som trengs før utfylling.

## M3 – gå gjennom hvert eneste felt

Pilotstatus 15. oktober 2026: Alle Kvittering-felter er dokumentert i `LEXWRITER_FELTGJENNOMGANG.md`. Skjemaet har fått vedvarende etiketter, påkrevd/valgfritt-markering, fiktive eksempler, rolleforklaringer og tydelig skille mellom betalingsdato og signeringsdato. Dokumentmodell og generert maltekst er uendret. Fire innholdsspørsmål er fortsatt åpne og skal avklares før malteksten eventuelt endres.

Lag en rad per felt i `LEXWRITER_FELTGJENNOMGANG.md` med følgende kolonner:

| Dokumenttype/felt | Betydning | Påkrevd/betinget/valgfritt | Forklaring | Fiktivt eksempel | Validering og feilmelding | Hvor verdien vises i dokumentet | Teststatus |
|---|---|---|---|---|---|---|---|

### Krav til utforming

- [ ] Felt har en synlig etikett som beholdes når brukeren skriver. Placeholder er ikke eneste forklaring.
- [ ] Forklar hvem opplysningen gjelder, hva som skal fylles inn og eventuelt hvorfor det trengs.
- [ ] Vis korte eksempler som tydelig er eksempler, ikke forhåndsutfylte personopplysninger.
- [ ] Marker obligatoriske, betingede og valgfrie felt konsekvent.
- [ ] Bruk riktig tastatur og inndatakontroll for tekst, dato, beløp og andre relevante datatyper.
- [ ] Støtt navn med mellomrom, bindestrek og nasjonale tegn; ikke innfør unødvendige begrensninger.
- [ ] Bruk forståelige rollenavn for parter; forklar hvem som er hvem før feltene fylles ut.
- [ ] Vis bare relevante betingede felt. Avklar håndtering av tidligere innhold når et valg endres, slik at skjulte verdier ikke kommer med feilaktig.
- [ ] Gi feil ved riktig felt med konkret forslag til retting. Bevar alt brukeren har skrevet ved valideringsfeil.
- [ ] Kontroller at tomme valgfrie felt ikke lager tomme avsnitt, doble tegn eller uferdige setninger i PDF.
- [ ] Be om sensitive identifikatorer bare der dokumentets behov er bekreftet. Eksempler må ikke bruke ekte identiteter.
- [ ] Gjør ekstra forklaringer tilgjengelige uten å sende brukeren bort fra skjemaet eller miste utfylling.
- [ ] Gjør etiketter, hjelpeknapper, obligatorisk status og feil forståelige med VoiceOver.

### Illustrasjoner – tilpasses den faktiske malen

| Hvis feltet finnes | Mulig forklaring |
|---|---|
| Part 1 / part 2 | Forklar rollen, for eksempel hvem som låner ut penger og hvem som låner |
| Beløp | Oppgi beløpet og valutaen avtalen gjelder; vis et format-eksempel |
| Dato | Forklar om dette er opprettelsesdato, startdato, forfall eller planlagt signeringsdato |
| Beskrivelse | Be om konkrete opplysninger om det avtalen gjelder og vis et kort, fiktivt eksempel |
| Varighet | Forklar start, slutt og eventuelt hva et åpent sluttidspunkt betyr i denne malen |

Eksemplene er mønstre for språk, ikke forslag til nye maler eller juridiske vilkår.

Ferdig når: Alle felt i piloten er gjennomgått og testet. Bruk deretter samme mønster på de øvrige eksisterende dokumenttypene og behold dokumenttype-spesifikke forklaringer.

## M4 – trygg utfylling fra start til ferdig utkast

Pilotstatus 15. oktober 2026: Kvittering har fått en lokal, versjonert kladd med automatisk lagring, gjenopprettingsstatus og eksplisitt sletting med bekreftelse. Lagringen bruker en egen nøkkel og testen bekrefter at kjøpsstatus ikke endres. Build og enhetstester består. Manuell verifisering av tilbake/gjenåpning, omstart og sletteknappen ble ikke fullført og er ikke markert som bestått.

- [ ] Del lange skjemaer i naturlige deler dersom det reduserer forvirring; ikke legg ekstra steg til korte skjemaer uten grunn.
- [ ] Vis fremdrift der den er nyttig, og gi enkel navigasjon tilbake til tidligere deler.
- [ ] Lagre utkast på en forutsigbar måte og gjør det tydelig om lagring er automatisk eller krever en handling.
- [ ] Test avbryt, bakgrunn, avslutning og omstart uten tap av utfylling.
- [ ] Gi et lett gjenkjennelig dokumentnavn og mulighet til å finne igjen utkastet.
- [ ] Vis en oppsummering før ferdigstilling, med direkte vei tilbake til felter som må endres.
- [ ] Skill mellom utkast, ferdig utfylt/eksportert og eventuelt signert dokument. Ikke merk noe som signert bare fordi det er eksportert.
- [ ] Kontroller duplisering og ny versjon hvis slike funksjoner finnes, slik at gamle dokumenter ikke overskrives utilsiktet.
- [ ] Rett krasj, feil datakobling og navigasjonsfeil som avdekkes underveis.

Ferdig når: Brukeren kan fylle ut, avbryte, fortsette, kontrollere og rette piloten uten å miste arbeid.

## M5 – dokumentinnhold, maler og forventninger

Pilotstatus 15. oktober 2026: Kvitteringens felt-til-dokument-kobling og tomme valgfrie felt er dekket av målrettet test. Offentlige norske primærkilder er kontrollert og dokumentert i `LEXWRITER_FUNN.md`. Piloten er nå tydelig avgrenset som en enkel betalingsbekreftelse, ikke salgsdokumentasjon for bokførings-/MVA-pliktige virksomheter. Maltekst og signaturstruktur er ikke endret; telefon/e-post og signaturbehov står åpne for produkt-/fagavklaring.

Dette er en kontroll av kvalitet og samsvar, ikke en antakelse om at Codex kan godkjenne alle dokumenter juridisk.

- [ ] Kontroller at alle felter havner hos riktig part og på riktig sted i dokumentet.
- [ ] Test at valg og betingelser gir riktig avsnitt og at bortvalgte vilkår ikke kommer med.
- [ ] Søk etter malmarkører, eksempelnavn, testlenker, manglende verdier og gamle hjelpetekster i generert dokument.
- [ ] Sammenlign opprinnelig og ny maltekst når språk endres. Dokumenter endringer som påvirker betydning.
- [ ] Registrer malens kilde, land/jurisdiksjon, versjon og dato for siste dokumenterte gjennomgang der dette kan fastslås.
- [ ] For juridiske krav og formkrav: verifiser mot gjeldende offentlige primærkilder for det aktuelle landet. Lagre kilde, dato, hva som er kontrollert og hva som fortsatt er uavklart.
- [ ] Skill språkvalg fra lovvalg. Engelsk eller thai grensesnitt betyr ikke automatisk at dokumentet er laget for britisk eller thailandsk rett.
- [ ] Dersom maler gjelder eksempelvis testament eller fullmakt, undersøk spesifikke formkrav og neste steg for akkurat den malen før det skrives veiledning.
- [ ] Ved uavklart faglig eller juridisk innhold: registrer det konkret for kvalifisert vurdering. Ikke erstatt uavklart innhold med generelle garantier eller improviserte vilkår.
- [ ] Vis korte og relevante neste steg for kontroll, utskrift og eventuell signering/vitner når dette er bekreftet for malen.
- [ ] Ikke endre tidligere ferdigstilte dokumenter automatisk når en mal oppdateres. Bevar opprinnelig innhold eller dokumentert versjonshåndtering.

Ferdig når: Innholdet stemmer med inndata og valgene. Uavklarte forhold som kan påvirke bruk av en mal er tydelig registrert og avklart før den berørte malen markedsføres eller utgis med nye påstander.

## M6 – pen PDF, enkel deling og utskrift

Pilotstatus 15. oktober 2026: Kvittering har fått forståelig, lokalisert PDF-filnavn og synlig feil ved mislykket PDF-klargjøring. Koordinatoren ignorerer ikke lenger filskrivingsfeil. Build og målrettede tester består. Full visuell forhåndsvisning, eksportert PDF, utskriftsdialog og fysisk AirPrint ble ikke fullført i simulatorrunden og er ikke markert som bestått.

- [ ] Kontroller at forhåndsvisningen samsvarer med den eksporterte PDF-en.
- [ ] Gjør «Forhåndsvis», «Lagre PDF», «Del» og «Skriv ut» forståelige og tilgjengelige der det passer.
- [ ] Bruk systemets utskriftsdialog og delingsark. Brukeren velger selv mottaker og lagringssted.
- [ ] Bruk lesbar A4-utforming, marger, tydelige overskrifter og konsistente avsnitt.
- [ ] Håndter lange navn, adresser, beløp og fritekst uten avklipping eller overlapp.
- [ ] Hold signaturfelt og eventuelle tilhørende forklaringer samlet så langt det er praktisk mulig.
- [ ] Kontroller sideskift, sidenummer og eventuell topp-/bunntekst ved flersidige dokumenter.
- [ ] Kontroller at norske tegn og andre tegnsett som dokumentene faktisk støtter, gjengis korrekt.
- [ ] Skill utfyllingshjelp fra selve dokumentteksten. Nødvendige bruksinstruksjoner skal være tydelige uten å bli utilsiktede avtalevilkår.
- [ ] Gi PDF-en et forståelig filnavn uten unødvendig sensitive identifikatorer.
- [ ] Test tomme valgfrie felt, lange tekster, flere sider, avbrutt eksport og gjentatt eksport.
- [ ] Test deling og lagring på iPhone. Gjennomfør fysisk AirPrint-test når en skriver er tilgjengelig, og noter hvis den gjenstår.

Ferdig når: Verifiserte dokumenter kan forhåndsvises, lagres, deles og skrives ut med korrekt innhold og lesbar utforming. Eksport alene er ikke bekreftelse på juridisk ferdigstilling.

## M7 – tilgjengelighet, språk og eksisterende funksjoner

- [ ] Test liten og stor iPhone og de iPad-visningene appen allerede støtter.
- [ ] Test store tekststørrelser, VoiceOver, kontrast, tastatur og tydelige trykkflater.
- [ ] Kontroller lyst, mørkt og systemutseende hvis støttet.
- [ ] Kontroller norsk, engelsk og thai hvis støttet: etiketter, eksempler, validering, navigasjon og PDF-tekst.
- [ ] Unngå halvoversatte skjemaer og avklippede feltforklaringer.
- [ ] Kontroller åpning, redigering og eksport av eksisterende utkast etter oppdatering på en kopi.
- [ ] Kontroller offlinebruk, omstart og eventuell synk i et adskilt oppsett.
- [ ] Kartlegg faktisk kjøpsmodell og test kjøp/gjenoppretting i støttet testmiljø hvis berørt, uten å endre priser eller tilgangsgrenser.
- [ ] Kontroller at et eventuelt kjøpsavbrudd eller feil ikke sletter brukerens utkast.
- [ ] Kontroller at support- og personvernlenker stemmer med den faktiske appen og fungerer.

Ferdig når: Forbedringene virker i støttede miljøer og ikke har ødelagt eksisterende dokumenter eller tilgang.

## M8 – vis nytten tydelig i norsk App Store-presentasjon

Gjennomfør etter at pilotflyten er forbedret og verifisert. Les den faktiske nåværende App Store-presentasjonen fra eierens materiale eller en bekreftet oppføring. Ikke gjett app-ID, dokumentutvalg, priser eller resultater.

Pilotstatus 18. oktober 2026: Norsk metadatautkast og skjermbildemanus er revidert i `LEXWRITER_APPSTORE_NO.md` etter bestått intern TestFlight-test av versjon 1.1 (6). Undertittel, promotional text og søkeord er kontrollert mot Apples gjeldende feltgrenser; søkeordene bruker 99 av 100 bytes uten å gjenta appnavnet eller undertittelen. Skjermbildemanuset bruker verifiserte appflyter, men påstår ikke at fysisk AirPrint er testet. Faktisk offentlig App Store-oppføring og aktive support-/personvernlenker må fortsatt kontrolleres av eieren før publisering.

- [ ] Beskriv målgruppen og hovednytten i én setning, basert på dokumentene som faktisk fungerer godt.
- [ ] Velg to–tre sterke brukssituasjoner fremfor å fremheve et stort antall maler.
- [ ] Lag forslag til undertittel, innledning, beskrivelse og relevante norske søkeord med konkrete dokumentnavn og brukerbehov.
- [ ] Kontroller gjeldende feltgrenser og Apple-krav i offisiell dokumentasjon før tekst og bilder ferdigstilles.
- [ ] Lag skjermbildeplan med korte, konkrete overskrifter og ekte appskjermer med fiktive data.
- [ ] La de første bildene vise nytten, veiledet utfylling og et lesbart resultat.
- [ ] Vis PDF/utskrift, lagrede utkast og andre fordeler bare når de er verifisert i aktuell build.
- [ ] Tilpass skjermbildene til norsk appvariant, relevante skjermstørrelser og faktiske funksjoner.
- [ ] Bruk ikke personlige dokumenter eller identifiserbare personer i bilder.
- [ ] Oppgi eventuell betaling og begrensninger presist. Unngå påstander om garantert gyldighet eller juridisk godkjenning uten grunnlag.
- [ ] Lag tekst og bildemanus i LEXWRITER_APPSTORE_NO.md. Marker forslag som utkast til eierens gjennomgang, ikke som publisert innhold.

Mulig bilderekkefølge, justert etter verifiserte funksjoner:

1. Velg et dokument som passer situasjonen din – vis faktiske dokumentvalg.
2. Få hjelp til hva du skal fylle inn – vis tydelig etikett, forklaring og eksempel.
3. Se dokumentet før du er ferdig – vis en lesbar forhåndsvisning.
4. Lagre PDF og skriv ut – vis den faktiske eksportflyten.
5. Fortsett på utkastet senere – bare dersom lagring/gjenopptakelse er bekreftet.

Ferdig når: Presentasjonen viser konkrete, verifiserte fordeler og har en sammenhengende vei fra App Store-løftet til faktisk bruk.

## M9 – test med mennesker som ikke kjenner appen

La eieren invitere tre–fem frivillige testere. Ikke send invitasjoner automatisk. Bruk fiktive opplysninger og en konkret oppgave for den valgte piloten.

Pilotstatus 15. oktober 2026: Testopplegget og anonymiserte resultater ligger i `LEXWRITER_BRUKERTEST.md`. Eier har fullført simulatorflyt og lokal lagring. Tre førstegangsbrukere har laget en kvittering; engelsk og thai ble fullført uten hjelp eller spørsmål. Den siste testeren fant at Tab fra Merknader ikke flyttet fokus videre. Det er rettet med eksplisitt fokusflytting til Sted og manuelt bekreftet på simulator. M9 er gjennomført. Fire automatiske regresjonstester ble avbrutt i Xcode og må kjøres igjen som del av M10.

Be testeren prøve uten veiledning først:

1. Forklar hva du tror LexWriter hjelper deg med.
2. Finn dokumentet som passer den beskrevne situasjonen.
3. Fyll ut dokumentet med de fiktive opplysningene.
4. Kontroller og rett én opplysning i forhåndsvisningen.
5. Lagre en PDF og finn utskrift.
6. Forklar hva som eventuelt gjenstår før dokumentet kan brukes.

- [ ] Registrer hvor testeren stopper, misforstår et felt eller trenger hjelp, uten å samle dokumentinnhold.
- [ ] Mål omtrent hvor lang tid piloten tar og hvor mange ganger testeren trenger hjelp; målingene brukes som utgangspunkt, ikke som udokumenterte markedsføringspåstander.
- [ ] Rett gjentatte misforståelser og prøv den berørte oppgaven igjen.
- [ ] Kontroller at testeren kan gjenåpne utkastet og finne igjen eksporten.
- [ ] La eieren teste med sine kjente dokumentflyter uten destruktive handlinger i aktiv lagring.
- [ ] Skriv ned gjenværende begrensninger og åpne feil.

Ferdig når: Pilotflyten kan fullføres uten hjelp av minst tre av de frivillige testerne, og det ikke gjenstår kjente kritiske innholds- eller dataproblemer. Hvis testere ikke er tilgjengelige, marker dette som gjenstående, ikke bestått.

## M10 – klargjør oppdatering og følg med på resultatet

Pilotstatus 18. oktober 2026: Build 6 ble testet internt via TestFlight. Under gjennomgang av en eksportert norsk PDF ble en blandet engelsk signeringsdato oppdaget. Dette er rettet og kontrollert i build 7 med målrettet språkstest, vellykket build og ny norsk PDF. Build 7 er arkivert, validert uten feil og lastet opp til App Store Connect. Build 6 skal ikke brukes til App Review. Appen er ikke publisert. Reell oppgradering med kopi av data fra en eldre build, fysisk AirPrint, største Dynamic Type/VoiceOver og full visuell PDF-matrise gjenstår før milepælen er komplett.

Versjon 1.1, build 7 er gjeldende kandidat. Den nødvendige datolokaliseringsrettelsen er manuelt bekreftet i eksportert PDF. Arkivet er validert uten feil og lastet opp til App Store Connect; det er ikke publisert.

- [ ] Kjør relevante tester for validering, felt-til-mal-kobling, betingede avsnitt, utkast og eksport. Skriv målrettede regresjonstester for feil som rettes.
- [ ] Gjør visuell PDF-kontroll og manuell test av hele pilotflyten i aktuell build.
- [ ] Test oppgradering med kopi av eldre data og kontroller at gamle dokumenter beholdes.
- [ ] Oppdater brukerveiledning og endringsnotater med faktisk gjennomførte forbedringer.
- [ ] Lag TestFlight-instruksjoner med fokus på feltforståelse, lagring, PDF og utskrift.
- [ ] Avklar kjente P0/P1-feil og relevante uavklarte malspørsmål før utgivelse.
- [ ] Klargjør norsk App Store-materiale, men la eieren gjennomføre publisering senere.
- [ ] Noter tilgjengelig utgangspunkt i App Store Connect: visninger, produktsidebesøk og nedlastinger etter Apples aktuelle definisjoner, hvis eieren har tilgang.
- [ ] Sammenlign like lange perioder før og etter oppdateringen, eksempelvis fire uker, og noter andre endringer som kan påvirke tallene.
- [ ] Skill mellom synlighet, nedlasting og faktisk bruk. Små tall gir usikre konklusjoner.
- [ ] Ikke legg til tredjepartssporing som standard. Vurder først tilgjengelig statistikk og frivillige tilbakemeldinger uten dokumentinnhold.

Ferdig når: En dokumentert og testet oppdatering er klar for eierens utgivelsesløp, med en enkel plan for å se om endringene hjelper.

## Avgrenset første leveranse

Prioriter disse før større utvidelser:

1. En verifisert oversikt over dokumenttyper og reelle mangler.
2. Én forbedret pilot med forståelige felt, riktige eksempler og trygt lagret utkast.
3. En korrekt, lesbar PDF og tydelige neste steg.
4. Samme forbedringsmønster innført i øvrige eksisterende maler.
5. Norsk App Store-presentasjon som viser den dokumenterte nytten.

Nye dokumenttyper, digital signering, AI-generering, samarbeid og nye abonnementer føres på en senere-liste med begrunnelse. Ikke utvid omfanget før hovedflyten er enkel og pålitelig.

## Fast rapport etter hver milepæl

- Hva er faktisk gjennomgått, forbedret og rettet?
- Hvilke filer og dokumenttyper er berørt?
- Hvilke tester ble utført, med hvilket resultat og i hvilket miljø?
- Hva er ikke testet, og hva skal eieren prøve på sin iPhone?
- Har endringen påvirket malinnhold, lagring, gamle dokumenter eller kjøpsrettigheter?
- Hvilke funn gjenstår, og hva er neste gjennomførbare steg?

## Starttekst til Codex

> Les LEXWRITER_FORBEDRING_MILESTONES.md, AGENTS.md og tidligere prosjektplaner. Begynn med M0 og M1: kartlegg eksisterende dokumenttyper og gjennomgå appen som en ny bruker. Opprett funnlisten og feltgjennomgangen. Velg én eksisterende dokumenttype som pilot, og forbedre først forståelsen av felter, eksempler, validering, utkast og veien til PDF/utskrift. Bevar alle eksisterende dokumenter og kjøpsrettigheter. Ikke bruk aktiv brukerlagring eller iCloud-data til testing. Skill språkforbedringer fra juridiske malendringer. Fortsett trinnvis etter planen og rapporter konkret hva jeg skal teste på min iPhone. Ikke publiser oppdateringen automatisk.

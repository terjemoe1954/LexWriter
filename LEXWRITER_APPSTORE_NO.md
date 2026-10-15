# LexWriter – norsk App Store-utkast

Status: Utkast til eierens gjennomgang. Ikke publisert. Sist kontrollert 15. oktober 2026 mot prosjektets build og Apples offisielle App Store Connect-dokumentasjon.

## Målgruppe og hovednytte

For privatpersoner som vil lage et ryddig utkast til en kvittering, avtale eller et lånedokument ved å fylle inn veiledede felt og kontrollere resultatet før utskrift.

Prioriterte brukssituasjoner:

1. Bekrefte en privat betaling med en enkel kvittering.
2. Lage et strukturert utkast til en privat avtale.
3. Samle partenes opplysninger og vilkår i et lånedokument.

## Metadataforslag

### Undertittel

`Dokumentmaler gjort enkelt`

26 tegn. Apples grense er 30 tegn.

### Innledning / promotional text

Fyll ut en kvittering eller privat avtale med tydelige felt, eksempler og kontroll før du gjør dokumentet klart for utskrift.

### Beskrivelse

LexWriter hjelper deg å lage ryddige dokumentutkast for vanlige private situasjoner.

Velg en mal og fyll inn opplysningene steg for steg. Kvitteringsmalen forklarer hva feltene betyr, viser fiktive eksempler og skiller mellom nødvendige og valgfrie opplysninger. Utfyllingen lagres lokalt som en kladd på enheten, slik at du kan fortsette senere.

Bruk LexWriter til blant annet:

- enkel kvittering for en privat betaling
- utkast til privat avtale
- lånedokument mellom parter

Kontroller dokumentet i forhåndsvisningen før du skriver det ut eller lagrer det som PDF. Norsk, engelsk og thai støttes i appen og dokumentene.

Dokumentene er maler og utkast, ikke juridisk rådgivning. Ved viktige eller kompliserte forhold bør dokumentet vurderes av advokat eller en annen kvalifisert rådgiver før signering. Den enkle kvitteringsmalen er ikke laget som salgsdokumentasjon for bokførings- eller MVA-pliktige virksomheter.

Premium-merker kan være synlige, men kjøp og premium-låsing er ikke aktivert i denne versjonen. Alle dokumentene er tilgjengelige i gjeldende build.

### Norske søkeord

`kvittering,avtale,kontrakt,låneavtale,fullmakt,testament,dokumentmal,utskrift,pdf`

82 UTF-8-bytes. Apples grense er 100 bytes. Appnavnet er ikke gjentatt.

## Skjermbildemanus

Bruk bare ekte appskjermer med fiktive navn, adresser, beløp og datoer. Første serie lages i norsk appvariant.

1. **Finn riktig dokument**  
   Vis dokumentoversikten med Kvittering, Kjøpsavtale og Låneavtale synlige. Unngå at premiumvisningen dominerer bildet.

2. **Se hva du skal fylle inn**  
   Vis toppen av Kvittering med «Før du begynner», omfangsadvarselen og eksempler. Bruk bare fiktive data.

3. **Tydelige felt underveis**  
   Vis vedvarende feltetiketter, «Påkrevd»/«Valgfritt» og et delvis utfylt skjema med Kari Eksempel og Ola Eksempel.

4. **Kontroller resultatet**  
   Vis den lesbare kvitteringsforhåndsvisningen først etter at den er kontrollert manuelt med norsk tekst, lange felter og signaturseksjonen.

5. **Fortsett senere**  
   Vis meldingen om gjenopprettet kladd først etter at tilbake, omstart og gjenåpning er bekreftet manuelt i aktuell build.

Ikke bruk PDF-/utskriftsdialog som markedsføringsbilde før M6-kontrollen av eksportert PDF og utskriftsflyten er fullført. Ikke bruk Premium-skjermen i den ordinære bildeserien.

## Apple-krav kontrollert 15. oktober 2026

- Appnavn: 2–30 tegn.
- Undertittel: maksimalt 30 tegn.
- Promotional text: maksimalt 170 tegn.
- Beskrivelse: maksimalt 4 000 tegn, ren tekst uten HTML.
- Søkeord: maksimalt 100 bytes; ikke gjenta app- eller selskapsnavn og ikke bruk navn på andre apper eller selskaper.
- Skjermbilder: minst 1 og maksimalt 10 per enhetsstørrelse, i JPEG/JPG/PNG og uten alfakanal.
- iPhone krever minst ett skjermbilde for Dynamic Island medium display. iPad 13-tommer kreves dersom appen støtter iPadOS.

Kilder: Apples «App information», «Platform version information», «Screenshot specifications» og «Upload app previews and screenshots» i App Store Connect Help.

## Før eventuell publisering

- Eier må sammenligne teksten med den faktiske norske oppføringen i App Store Connect; prosjektet inneholder bare tidligere arbeidsutkast, ikke en bekreftet offentlig oppføring.
- Bekreft støttede enheter og ta skjermbilder i de størrelsene App Store Connect faktisk ber om for denne appen.
- Fullfør manuell kontroll av kvitteringsforhåndsvisning, PDF, utskrift og gjenopprettet kladd før bilde 4–5 brukes.
- Bekreft at support- og personvernlenkene i App Store Connect er aktive.
- Behold presis melding om at kjøp ikke er tilgjengelig så lenge StoreKit og premiumhåndheving er deaktivert.

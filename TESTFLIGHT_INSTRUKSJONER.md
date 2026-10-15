# LexWriter – TestFlight-instruksjoner

Status 15. oktober 2026: Versjon 1.1, build 6 er validert og lastet opp til App Store Connect. Bygget er tilgjengelig i TestFlight, men er ikke publisert i App Store.

## Fokus for denne builden

Test den forbedrede Kvittering-flyten med bare fiktive opplysninger:

1. Åpne Kvittering og kontroller veiledningen og omfangsadvarselen.
2. Fyll ut alle påkrevde felt og noen valgfrie felt.
3. Bruk Tab fra Merknader og kontroller at fokus flyttes til Sted.
4. Gå tilbake, lukk appen og åpne Kvittering igjen. Kontroller at kladden gjenopprettes.
5. Endre én opplysning og kontroller forhåndsvisningen.
6. Lagre PDF lokalt og kontroller tekst, lange felt og signaturseksjon.
7. Åpne utskriftsdialogen. Skriv bare ut dersom et avtalt testoppsett er tilgjengelig.
8. Gjenta hovedflyten på norsk, engelsk eller thai.

## Rapporter

- Enhetsmodell, iOS-versjon, appversjon/build og språk.
- Om feilen gjelder utfylling, kladd, forhåndsvisning, PDF eller utskrift.
- Hvilket felt eller trinn som stoppet.
- Om data forsvant eller ble endret.
- Skjermbilde uten personopplysninger hvis det er nødvendig.

Ikke send utfylte dokumenter eller virkelige personopplysninger. Dokumentene er maler og utkast, ikke juridisk rådgivning.

## Kjente gjenstående kontroller

- Fysisk AirPrint.
- Største Dynamic Type og faktisk VoiceOver-leserekkefølge på en fysisk enhet.
- Oppgradering fra eldre build med kopi av eksisterende data.
- Full visuell sammenligning mellom forhåndsvisning og eksportert PDF på liten iPhone, stor iPhone og iPad.

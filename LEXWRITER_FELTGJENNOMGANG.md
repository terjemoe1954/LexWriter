# LexWriter – feltgjennomgang

Sist oppdatert: 15. oktober 2026  
Pilot: Kvittering

Status beskriver pilotimplementeringen. Hjelpetekst og eksempler er produkttekst og endrer ikke den juridiske malteksten.

| Dokumenttype/felt | Betydning | Påkrevd/betinget/valgfritt | Forklaring | Fiktivt eksempel | Validering og feilmelding | Hvor verdien vises i dokumentet | Teststatus |
|---|---|---|---|---|---|---|---|
| Kvittering / Utsteder – navn | Den som har mottatt betalingen og utsteder kvitteringen | Påkrevd | «Navnet på personen eller virksomheten som mottok betalingen.» | Kari Eksempel | Samlet feil krever navn og adresse | Punkt 1 og signaturlinje | Modelltest bestått; UI observert |
| Kvittering / Utsteder – adresse | Adressen til betalingsmottakeren | Påkrevd | «Adressen til personen eller virksomheten som mottok betalingen.» | Eksempelveien 10, 0123 Oslo | Samlet feil krever navn og adresse | Punkt 1 | Modelltest bestått; UI observert |
| Kvittering / Utsteder – telefon | Kontaktinformasjon | Valgfritt | «Telefonnummer til betalingsmottakeren, hvis det skal stå i kontaktopplysningene.» | 900 00 000 | Ingen validering; telefon-tastatur | Ikke synlig i dagens dokumenttekst | Kartlagt; innholdsbehov må avklares |
| Kvittering / Utsteder – e-post | Kontaktinformasjon | Valgfritt | «E-post til betalingsmottakeren, hvis den skal stå i kontaktopplysningene.» | kari@example.no | Ingen validering; e-posttastatur | Ikke synlig i dagens dokumenttekst | Kartlagt; innholdsbehov må avklares |
| Kvittering / Betaler – navn | Den som har betalt | Påkrevd | «Navnet på personen eller virksomheten som betalte.» | Ola Eksempel | Samlet feil krever navn og adresse | Punkt 2 og signaturlinje | Modelltest bestått; UI observert |
| Kvittering / Betaler – adresse | Adressen til betaleren | Påkrevd | «Adressen til personen eller virksomheten som betalte.» | Prøvegata 4, 0456 Oslo | Samlet feil krever navn og adresse | Punkt 2 | Modelltest bestått; UI observert |
| Kvittering / Betaler – telefon | Kontaktinformasjon | Valgfritt | «Telefonnummer til betaleren, hvis det skal stå i kontaktopplysningene.» | 911 11 111 | Ingen validering; telefon-tastatur | Ikke synlig i dagens dokumenttekst | Kartlagt; innholdsbehov må avklares |
| Kvittering / Betaler – e-post | Kontaktinformasjon | Valgfritt | «E-post til betaleren, hvis den skal stå i kontaktopplysningene.» | ola@example.no | Ingen validering; e-posttastatur | Ikke synlig i dagens dokumenttekst | Kartlagt; innholdsbehov må avklares |
| Kvittering / Hva gjelder betalingen? | Varen, tjenesten eller forpliktelsen betalingen gjelder | Påkrevd | «Beskriv kort hva det er betalt for.» | Brukt skrivebord, serienummer 1234 | Blokkerer forhåndsvisning hvis tomt | Punkt 3 | Modelltest bestått; UI observert |
| Kvittering / Beløp | Mottatt beløp og valuta | Påkrevd | «Skriv beløp og valuta.» | 2 500 NOK | Blokkerer bare hvis tomt; ingen formatkontroll | Punkt 3 | Modelltest bestått; format ikke testet |
| Kvittering / Betalingsdato | Dato betalingen faktisk ble mottatt | Påkrevd | «Datoen betalingen ble mottatt.» | 15.10.2026 | Blokkerer bare hvis tomt; fritekst | Punkt 3 | Modelltest bestått; format ikke testet |
| Kvittering / Betalingsmåte | Hvordan betalingen ble gjort | Anbefalt/valgfritt | «For eksempel kontant, bankoverføring eller Vipps.» | Bankoverføring | Advarsel hvis tomt; standardtekst settes i dokumentet | Punkt 3 | Modelltest bestått; UI observert |
| Kvittering / Merknader eller referanse | Referanse eller presisering | Valgfritt | «For eksempel fakturanummer eller avtalt referanse.» | Referanse 2026-014 | Advarsel hvis tomt; standardtekst settes i dokumentet | Punkt 4 | Modelltest bestått; UI observert |
| Kvittering / Sted | Stedet dokumentet signeres | Påkrevd | «Stedet der kvitteringen signeres.» | Oslo | Blokkerer forhåndsvisning hvis tomt | Signaturdelen | Modelltest bestått; UI observert |
| Kvittering / Dato | Datoen dokumentet signeres | Påkrevd med dagens kontroll | «Datoen kvitteringen signeres. Dette kan være en annen dato enn betalingsdatoen.» | 15. oktober 2026 | Alltid satt av `DatePicker` | Signaturdelen | Kartlagt; UI observert |

## Åpne pilotspørsmål før malinnhold eventuelt endres

- Skal telefon og e-post faktisk med i kvitteringen? I dag samles de inn, men brukes ikke i dokumentet.
- Skal beløp kreve eksplisitt valuta, eller skal norsk standardverdi vises uten å endre malens betydning?
- Skal betalingsdato være en ekte datokontroll og kunne avvike fra signeringsdato?
- Skal bare utsteder signere en kvittering, eller er begge signaturlinjene tilsiktet? Dette må avklares før maltekst endres.

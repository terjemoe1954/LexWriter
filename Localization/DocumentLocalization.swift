//
//  DocumentLocalization.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import Foundation

enum ContractLocalizedKey {
    case cardSubtitle
    case legalChecklistTitle
    case partyOneTitle
    case partyTwoTitle
    case agreementDetailsTitle
    case agreementTitleField
    case subjectField
    case deliveryField
    case paymentField
    case durationField
    case breachField
    case terminationField
    case disputeResolutionField
    case specialTermsField
    case previewButton
    case blockingPartyOne
    case blockingPartyTwo
    case blockingTitle
    case blockingSubject
    case blockingPayment
    case blockingBreach
    case blockingPlace
    case warningDuration
    case warningTermination
    case warningDisputeResolution
    case warningSpecialTerms
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case clauseSevenTitle
    case clauseEightTitle
    case bodyIntroPrefix
    case bodyIntroMiddle
    case bodySubjectPrefix
    case bodyDeliveryPrefix
    case bodyPaymentPrefix
    case bodyDurationPrefix
    case bodyBreachPrefix
    case bodyTerminationPrefix
    case bodyDisputePrefix
    case bodySpecialTermsPrefix
    case bodyGoodFaith
    case defaultDuration
    case defaultTermination
    case defaultDisputeResolution
    case defaultSpecialTerms
}

enum PowerOfAttorneyLocalizedKey {
    case cardSubtitle
    case legalChecklistTitle
    case principalTitle
    case agentTitle
    case mandateTitle
    case purposeField
    case scopeField
    case restrictionsField
    case validFromField
    case validUntilField
    case revocationField
    case previewButton
    case blockingPrincipal
    case blockingAgent
    case blockingScope
    case blockingPurpose
    case blockingPlace
    case warningDuration
    case warningRestrictions
    case warningRevocation
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyIntroPrefix
    case bodyIntroMiddle
    case bodyIntroSuffix
    case bodyPurposePrefix
    case bodyScopePrefix
    case bodyRestrictionsPrefix
    case bodyValidityPrefix
    case bodyRevocationPrefix
    case bodyThirdPartyNotice
    case contactHeader
    case defaultRestrictions
    case defaultValidity
    case defaultRevocation
}

extension AppLanguage {
    var contractChecklist: [String] {
        [
            contractText(.bodySubjectPrefix).replacingOccurrences(of: "Avtalen gjelder", with: "Avtalen bør tydelig angi hva den gjelder").replacingOccurrences(of: "This agreement concerns", with: "The agreement should clearly state what it concerns").replacingOccurrences(of: "สัญญานี้เกี่ยวกับ", with: "สัญญาควรระบุให้ชัดเจนว่าเกี่ยวกับอะไร"),
            contractText(.warningTermination).replacingOccurrences(of: ".", with: ""),
            contractText(.warningSpecialTerms).replacingOccurrences(of: ".", with: "")
        ]
    }

    var powerOfAttorneyChecklist: [String] {
        [
            powerOfAttorneyText(.bodyScopePrefix).replacingOccurrences(of: "Fullmakten omfatter", with: "Fullmakten bør angi klart hva den omfatter").replacingOccurrences(of: "The power of attorney covers", with: "The power of attorney should clearly state what it covers").replacingOccurrences(of: "หนังสือมอบอำนาจนี้ครอบคลุม", with: "หนังสือมอบอำนาจควรระบุขอบเขตให้ชัดเจน"),
            powerOfAttorneyText(.warningDuration).replacingOccurrences(of: ".", with: ""),
            powerOfAttorneyText(.warningRestrictions).replacingOccurrences(of: ".", with: "")
        ]
    }

    func contractText(_ key: ContractLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .cardSubtitle):
            return "Lag en ryddig avtale med parter, vilkår, betaling og signaturfelt."
        case (.norwegian, .legalChecklistTitle):
            return "Det som bør være tydelig i kontrakten"
        case (.norwegian, .partyOneTitle):
            return "Part 1"
        case (.norwegian, .partyTwoTitle):
            return "Part 2"
        case (.norwegian, .agreementDetailsTitle):
            return "Avtaledetaljer"
        case (.norwegian, .agreementTitleField):
            return "Avtalens tittel"
        case (.norwegian, .subjectField):
            return "Hva gjelder avtalen?"
        case (.norwegian, .deliveryField):
            return "Ytelse, leveranse eller gjenstand"
        case (.norwegian, .paymentField):
            return "Pris, honorar eller betalingsvilkår"
        case (.norwegian, .durationField):
            return "Varighet eller oppstart"
        case (.norwegian, .breachField):
            return "Hva skjer ved mislighold eller forsinkelse?"
        case (.norwegian, .terminationField):
            return "Oppsigelse eller avslutning"
        case (.norwegian, .disputeResolutionField):
            return "Lovvalg, verneting eller hvordan tvister skal løses"
        case (.norwegian, .specialTermsField):
            return "Særlige vilkår"
        case (.norwegian, .previewButton):
            return "Vis kontrakt"
        case (.norwegian, .blockingPartyOne):
            return "Part 1 må ha navn og adresse."
        case (.norwegian, .blockingPartyTwo):
            return "Part 2 må ha navn og adresse."
        case (.norwegian, .blockingTitle):
            return "Avtalens tittel mangler."
        case (.norwegian, .blockingSubject):
            return "Avtalens formål og leveranse må beskrives."
        case (.norwegian, .blockingPayment):
            return "Pris eller betalingsvilkår må fylles inn."
        case (.norwegian, .blockingBreach):
            return "Det må beskrives hva som gjelder ved mislighold eller forsinkelse."
        case (.norwegian, .blockingPlace):
            return "Sted for signering mangler."
        case (.norwegian, .warningDuration):
            return "Varighet eller oppstart er ikke fylt inn. Det kan skape uklarhet om når avtalen gjelder."
        case (.norwegian, .warningTermination):
            return "Oppsigelse eller avslutning er ikke regulert. Det bør normalt stå hvordan avtalen kan avsluttes."
        case (.norwegian, .warningDisputeResolution):
            return "Tvisteløsning eller lovvalg er ikke fylt inn. Det bør normalt fremgå hvilken rett og hvordan uenighet skal håndteres."
        case (.norwegian, .warningSpecialTerms):
            return "Særlige vilkår er tomt. Dersom det finnes ansvar, frister eller forbehold bør de skrives inn."
        case (.norwegian, .clauseOneTitle):
            return "1. Parter"
        case (.norwegian, .clauseTwoTitle):
            return "2. Avtalens formål og ytelse"
        case (.norwegian, .clauseThreeTitle):
            return "3. Betaling"
        case (.norwegian, .clauseFourTitle):
            return "4. Varighet"
        case (.norwegian, .clauseFiveTitle):
            return "5. Mislighold"
        case (.norwegian, .clauseSixTitle):
            return "6. Opphør"
        case (.norwegian, .clauseSevenTitle):
            return "7. Lovvalg og tvister"
        case (.norwegian, .clauseEightTitle):
            return "8. Særlige vilkår"
        case (.norwegian, .bodyIntroPrefix):
            return "Mellom"
        case (.norwegian, .bodyIntroMiddle):
            return "og"
        case (.norwegian, .bodySubjectPrefix):
            return "Avtalen gjelder"
        case (.norwegian, .bodyDeliveryPrefix):
            return "Partene er enige om følgende ytelse eller leveranse"
        case (.norwegian, .bodyPaymentPrefix):
            return "Betaling og økonomiske vilkår er satt til"
        case (.norwegian, .bodyDurationPrefix):
            return "Avtalen gjelder fra og med / i perioden"
        case (.norwegian, .bodyBreachPrefix):
            return "Ved mislighold, forsinkelse eller annen kontraktsbruddssituasjon gjelder følgende"
        case (.norwegian, .bodyTerminationPrefix):
            return "Avtalen kan sies opp eller avsluttes slik"
        case (.norwegian, .bodyDisputePrefix):
            return "Partene er enige om følgende lovvalg eller tvisteløsningsordning"
        case (.norwegian, .bodySpecialTermsPrefix):
            return "Særlige vilkår:"
        case (.norwegian, .bodyGoodFaith):
            return "Partene bekrefter at avtalen er lest, forstått og inngått frivillig."
        case (.norwegian, .defaultDuration):
            return "til den sies opp i samsvar med denne avtalen"
        case (.norwegian, .defaultTermination):
            return "Avtalen kan sies opp skriftlig med rimelig varsel."
        case (.norwegian, .defaultDisputeResolution):
            return "Norsk rett gjelder, og tvister søkes løst i minnelighet før ordinær domstolsbehandling."
        case (.norwegian, .defaultSpecialTerms):
            return "Ingen ytterligere særlige vilkår er avtalt."
        case (.english, .cardSubtitle):
            return "Prepare a clear agreement with parties, terms, payment, and signature fields."
        case (.english, .legalChecklistTitle):
            return "What should be clear in the contract"
        case (.english, .partyOneTitle):
            return "Party 1"
        case (.english, .partyTwoTitle):
            return "Party 2"
        case (.english, .agreementDetailsTitle):
            return "Agreement details"
        case (.english, .agreementTitleField):
            return "Agreement title"
        case (.english, .subjectField):
            return "What is the agreement about?"
        case (.english, .deliveryField):
            return "Services, delivery, or subject matter"
        case (.english, .paymentField):
            return "Price, fee, or payment terms"
        case (.english, .durationField):
            return "Duration or commencement"
        case (.english, .breachField):
            return "What happens in case of breach or delay?"
        case (.english, .terminationField):
            return "Termination or ending"
        case (.english, .disputeResolutionField):
            return "Governing law, venue, or dispute resolution"
        case (.english, .specialTermsField):
            return "Special terms"
        case (.english, .previewButton):
            return "Show contract"
        case (.english, .blockingPartyOne):
            return "Party 1 must have a name and address."
        case (.english, .blockingPartyTwo):
            return "Party 2 must have a name and address."
        case (.english, .blockingTitle):
            return "The agreement title is missing."
        case (.english, .blockingSubject):
            return "The purpose and deliverable of the agreement must be described."
        case (.english, .blockingPayment):
            return "Price or payment terms must be entered."
        case (.english, .blockingBreach):
            return "The consequences of breach or delay must be described."
        case (.english, .blockingPlace):
            return "The place of signing is missing."
        case (.english, .warningDuration):
            return "Duration or commencement is not filled in. That can create uncertainty about when the agreement applies."
        case (.english, .warningTermination):
            return "Termination is not regulated. The agreement should normally say how it can be ended."
        case (.english, .warningDisputeResolution):
            return "Dispute resolution or governing law is not filled in. The agreement should normally state which law applies and how disagreements are handled."
        case (.english, .warningSpecialTerms):
            return "Special terms are empty. If there are liabilities, deadlines, or reservations, they should be written in."
        case (.english, .clauseOneTitle):
            return "1. Parties"
        case (.english, .clauseTwoTitle):
            return "2. Purpose and performance"
        case (.english, .clauseThreeTitle):
            return "3. Payment"
        case (.english, .clauseFourTitle):
            return "4. Duration"
        case (.english, .clauseFiveTitle):
            return "5. Breach"
        case (.english, .clauseSixTitle):
            return "6. Termination"
        case (.english, .clauseSevenTitle):
            return "7. Governing law and disputes"
        case (.english, .clauseEightTitle):
            return "8. Special terms"
        case (.english, .bodyIntroPrefix):
            return "Between"
        case (.english, .bodyIntroMiddle):
            return "and"
        case (.english, .bodySubjectPrefix):
            return "This agreement concerns"
        case (.english, .bodyDeliveryPrefix):
            return "The parties agree to the following service or delivery"
        case (.english, .bodyPaymentPrefix):
            return "Payment and financial terms are set as"
        case (.english, .bodyDurationPrefix):
            return "The agreement applies from / during"
        case (.english, .bodyBreachPrefix):
            return "In the event of breach, delay, or other non-performance, the following shall apply"
        case (.english, .bodyTerminationPrefix):
            return "The agreement may be terminated as follows"
        case (.english, .bodyDisputePrefix):
            return "The parties agree to the following governing law or dispute resolution arrangement"
        case (.english, .bodySpecialTermsPrefix):
            return "Special terms:"
        case (.english, .bodyGoodFaith):
            return "The parties confirm that the agreement has been read, understood, and entered into voluntarily."
        case (.english, .defaultDuration):
            return "until terminated in accordance with this agreement"
        case (.english, .defaultTermination):
            return "The agreement may be terminated in writing with reasonable notice."
        case (.english, .defaultDisputeResolution):
            return "Norwegian law applies, and disputes should first be addressed amicably before ordinary court proceedings."
        case (.english, .defaultSpecialTerms):
            return "No additional special terms have been agreed."
        case (.thai, .cardSubtitle):
            return "จัดทำสัญญาที่ชัดเจนพร้อมคู่สัญญา เงื่อนไข การชำระเงิน และช่องลงนาม"
        case (.thai, .legalChecklistTitle):
            return "สิ่งที่ควรระบุให้ชัดในสัญญา"
        case (.thai, .partyOneTitle):
            return "คู่สัญญาฝ่ายที่ 1"
        case (.thai, .partyTwoTitle):
            return "คู่สัญญาฝ่ายที่ 2"
        case (.thai, .agreementDetailsTitle):
            return "รายละเอียดสัญญา"
        case (.thai, .agreementTitleField):
            return "ชื่อสัญญา"
        case (.thai, .subjectField):
            return "สัญญานี้เกี่ยวกับอะไร"
        case (.thai, .deliveryField):
            return "บริการ การส่งมอบ หรือทรัพย์สินที่เกี่ยวข้อง"
        case (.thai, .paymentField):
            return "ราคา ค่าตอบแทน หรือเงื่อนไขการชำระเงิน"
        case (.thai, .durationField):
            return "ระยะเวลาหรือวันเริ่มต้น"
        case (.thai, .breachField):
            return "หากผิดสัญญาหรือล่าช้าจะเกิดอะไรขึ้น"
        case (.thai, .terminationField):
            return "การยกเลิกหรือสิ้นสุดสัญญา"
        case (.thai, .disputeResolutionField):
            return "กฎหมายที่ใช้ ศาลที่มีอำนาจ หรือวิธีระงับข้อพิพาท"
        case (.thai, .specialTermsField):
            return "เงื่อนไขพิเศษ"
        case (.thai, .previewButton):
            return "แสดงสัญญา"
        case (.thai, .blockingPartyOne):
            return "คู่สัญญาฝ่ายที่ 1 ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingPartyTwo):
            return "คู่สัญญาฝ่ายที่ 2 ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingTitle):
            return "ยังไม่ได้กรอกชื่อสัญญา"
        case (.thai, .blockingSubject):
            return "ต้องอธิบายวัตถุประสงค์และสิ่งที่จะส่งมอบตามสัญญา"
        case (.thai, .blockingPayment):
            return "ต้องกรอกราคาหรือเงื่อนไขการชำระเงิน"
        case (.thai, .blockingBreach):
            return "ต้องอธิบายผลที่ตามมาหากมีการผิดสัญญาหรือล่าช้า"
        case (.thai, .blockingPlace):
            return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningDuration):
            return "ยังไม่ได้กรอกระยะเวลาหรือวันเริ่มต้น อาจทำให้ไม่ชัดเจนว่าสัญญามีผลเมื่อใด"
        case (.thai, .warningTermination):
            return "ยังไม่ได้ระบุวิธียกเลิกหรือสิ้นสุดสัญญา โดยปกติควรระบุเรื่องนี้ให้ชัด"
        case (.thai, .warningDisputeResolution):
            return "ยังไม่ได้ระบุวิธีระงับข้อพิพาทหรือกฎหมายที่ใช้ โดยปกติควรระบุให้ชัดว่าใช้กฎหมายใดและจัดการข้อขัดแย้งอย่างไร"
        case (.thai, .warningSpecialTerms):
            return "ช่องเงื่อนไขพิเศษยังว่าง หากมีความรับผิด กำหนดเวลา หรือข้อสงวน ควรระบุไว้"
        case (.thai, .clauseOneTitle):
            return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle):
            return "2. วัตถุประสงค์และหน้าที่ตามสัญญา"
        case (.thai, .clauseThreeTitle):
            return "3. การชำระเงิน"
        case (.thai, .clauseFourTitle):
            return "4. ระยะเวลา"
        case (.thai, .clauseFiveTitle):
            return "5. การผิดสัญญา"
        case (.thai, .clauseSixTitle):
            return "6. การสิ้นสุดสัญญา"
        case (.thai, .clauseSevenTitle):
            return "7. กฎหมายที่ใช้และข้อพิพาท"
        case (.thai, .clauseEightTitle):
            return "8. เงื่อนไขพิเศษ"
        case (.thai, .bodyIntroPrefix):
            return "ระหว่าง"
        case (.thai, .bodyIntroMiddle):
            return "และ"
        case (.thai, .bodySubjectPrefix):
            return "สัญญานี้เกี่ยวกับ"
        case (.thai, .bodyDeliveryPrefix):
            return "คู่สัญญาตกลงกันเกี่ยวกับบริการหรือการส่งมอบดังต่อไปนี้"
        case (.thai, .bodyPaymentPrefix):
            return "การชำระเงินและเงื่อนไขทางการเงินกำหนดไว้ดังนี้"
        case (.thai, .bodyDurationPrefix):
            return "สัญญามีผลตั้งแต่ / ในช่วงเวลา"
        case (.thai, .bodyBreachPrefix):
            return "ในกรณีผิดสัญญา ล่าช้า หรือไม่ปฏิบัติตามสัญญา ให้ใช้เงื่อนไขดังต่อไปนี้"
        case (.thai, .bodyTerminationPrefix):
            return "สัญญาสามารถยกเลิกหรือสิ้นสุดได้ดังนี้"
        case (.thai, .bodyDisputePrefix):
            return "คู่สัญญาตกลงใช้กฎหมายหรือวิธีระงับข้อพิพาทดังต่อไปนี้"
        case (.thai, .bodySpecialTermsPrefix):
            return "เงื่อนไขพิเศษ:"
        case (.thai, .bodyGoodFaith):
            return "คู่สัญญายืนยันว่าได้อ่าน เข้าใจ และทำสัญญานี้โดยสมัครใจ"
        case (.thai, .defaultDuration):
            return "จนกว่าจะมีการยกเลิกตามเงื่อนไขของสัญญานี้"
        case (.thai, .defaultTermination):
            return "สัญญานี้อาจยกเลิกเป็นลายลักษณ์อักษรโดยแจ้งล่วงหน้าอย่างสมเหตุสมผล"
        case (.thai, .defaultDisputeResolution):
            return "ให้ใช้กฎหมายนอร์เวย์ และคู่สัญญาจะพยายามเจรจาไกล่เกลี่ยก่อนเข้าสู่กระบวนการศาลปกติ"
        case (.thai, .defaultSpecialTerms):
            return "ไม่มีเงื่อนไขพิเศษเพิ่มเติมที่ตกลงกันไว้"
        }
    }

    func powerOfAttorneyText(_ key: PowerOfAttorneyLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .cardSubtitle):
            return "Lag en formell fullmakt med fullmaktsgiver, fullmektig, omfang og gyldighet."
        case (.norwegian, .legalChecklistTitle):
            return "Det som bør være tydelig i fullmakten"
        case (.norwegian, .principalTitle):
            return "Fullmaktsgiver"
        case (.norwegian, .agentTitle):
            return "Fullmektig"
        case (.norwegian, .mandateTitle):
            return "Omfang og gyldighet"
        case (.norwegian, .purposeField):
            return "Hva er formålet med fullmakten?"
        case (.norwegian, .scopeField):
            return "Hva skal fullmakten omfatte?"
        case (.norwegian, .restrictionsField):
            return "Begrensninger eller forbehold"
        case (.norwegian, .validFromField):
            return "Gyldig fra"
        case (.norwegian, .validUntilField):
            return "Gyldig til"
        case (.norwegian, .revocationField):
            return "Hvordan kan fullmakten tilbakekalles?"
        case (.norwegian, .previewButton):
            return "Vis fullmakt"
        case (.norwegian, .blockingPrincipal):
            return "Fullmaktsgiver må ha navn og adresse."
        case (.norwegian, .blockingAgent):
            return "Fullmektig må ha navn og adresse."
        case (.norwegian, .blockingScope):
            return "Fullmaktens omfang må beskrives."
        case (.norwegian, .blockingPurpose):
            return "Formålet med fullmakten må beskrives."
        case (.norwegian, .blockingPlace):
            return "Sted for signering mangler."
        case (.norwegian, .warningDuration):
            return "Gyldighetstid er ikke angitt. Det bør fremgå hvor lenge fullmakten skal gjelde."
        case (.norwegian, .warningRestrictions):
            return "Begrensninger eller forbehold er tomt. Dersom fullmakten ikke skal være generell, bør grensene skrives tydelig."
        case (.norwegian, .warningRevocation):
            return "Tilbakekall er ikke regulert. Det bør fremgå hvordan fullmakten kan trekkes tilbake og når tilbakekallet får virkning."
        case (.norwegian, .clauseOneTitle):
            return "1. Fullmaktsgiver og fullmektig"
        case (.norwegian, .clauseTwoTitle):
            return "2. Formål"
        case (.norwegian, .clauseThreeTitle):
            return "3. Omfang"
        case (.norwegian, .clauseFourTitle):
            return "4. Begrensninger"
        case (.norwegian, .clauseFiveTitle):
            return "5. Gyldighet"
        case (.norwegian, .clauseSixTitle):
            return "6. Tilbakekall"
        case (.norwegian, .bodyIntroPrefix):
            return "Jeg,"
        case (.norwegian, .bodyIntroMiddle):
            return "gir herved"
        case (.norwegian, .bodyIntroSuffix):
            return "fullmakt til å handle på mine vegne."
        case (.norwegian, .bodyPurposePrefix):
            return "Fullmakten gis med følgende formål"
        case (.norwegian, .bodyScopePrefix):
            return "Fullmakten omfatter"
        case (.norwegian, .bodyRestrictionsPrefix):
            return "Følgende begrensninger gjelder:"
        case (.norwegian, .bodyValidityPrefix):
            return "Fullmakten gjelder i perioden"
        case (.norwegian, .bodyRevocationPrefix):
            return "Fullmakten kan tilbakekalles slik"
        case (.norwegian, .bodyThirdPartyNotice):
            return "Tredjeperson kan bare legge fullmakten til grunn innenfor det omfang som følger av dette dokumentet og av avtalelovens fullmaktsregler."
        case (.norwegian, .contactHeader):
            return "Kontaktopplysninger til fullmaktsgiver:"
        case (.norwegian, .defaultRestrictions):
            return "Fullmektigen kan ikke gå utover det som uttrykkelig fremgår av denne fullmakten."
        case (.norwegian, .defaultValidity):
            return "fra undertegning og inntil den tilbakekalles skriftlig"
        case (.norwegian, .defaultRevocation):
            return "Fullmakten kan når som helst tilbakekalles skriftlig av fullmaktsgiver. Tilbakekall bør meddeles fullmektigen og relevante tredjepersoner uten ugrunnet opphold."
        case (.english, .cardSubtitle):
            return "Prepare a formal power of attorney with principal, agent, scope, and validity."
        case (.english, .legalChecklistTitle):
            return "What should be clear in the power of attorney"
        case (.english, .principalTitle):
            return "Principal"
        case (.english, .agentTitle):
            return "Agent"
        case (.english, .mandateTitle):
            return "Scope and validity"
        case (.english, .purposeField):
            return "What is the purpose of the power of attorney?"
        case (.english, .scopeField):
            return "What should the power of attorney cover?"
        case (.english, .restrictionsField):
            return "Restrictions or reservations"
        case (.english, .validFromField):
            return "Valid from"
        case (.english, .validUntilField):
            return "Valid until"
        case (.english, .revocationField):
            return "How may the power of attorney be revoked?"
        case (.english, .previewButton):
            return "Show power of attorney"
        case (.english, .blockingPrincipal):
            return "The principal must have a name and address."
        case (.english, .blockingAgent):
            return "The agent must have a name and address."
        case (.english, .blockingScope):
            return "The scope of authority must be described."
        case (.english, .blockingPurpose):
            return "The purpose of the power of attorney must be described."
        case (.english, .blockingPlace):
            return "The place of signing is missing."
        case (.english, .warningDuration):
            return "No validity period is stated. It should be clear how long the authority remains in effect."
        case (.english, .warningRestrictions):
            return "Restrictions are empty. If the authority is not meant to be general, the limits should be written clearly."
        case (.english, .warningRevocation):
            return "Revocation is not regulated. The document should state how the authority may be withdrawn and when the withdrawal takes effect."
        case (.english, .clauseOneTitle):
            return "1. Principal and agent"
        case (.english, .clauseTwoTitle):
            return "2. Purpose"
        case (.english, .clauseThreeTitle):
            return "3. Scope"
        case (.english, .clauseFourTitle):
            return "4. Restrictions"
        case (.english, .clauseFiveTitle):
            return "5. Validity"
        case (.english, .clauseSixTitle):
            return "6. Revocation"
        case (.english, .bodyIntroPrefix):
            return "I,"
        case (.english, .bodyIntroMiddle):
            return "hereby grant"
        case (.english, .bodyIntroSuffix):
            return "authority to act on my behalf."
        case (.english, .bodyPurposePrefix):
            return "This authority is granted for the following purpose"
        case (.english, .bodyScopePrefix):
            return "The power of attorney covers"
        case (.english, .bodyRestrictionsPrefix):
            return "The following restrictions apply:"
        case (.english, .bodyValidityPrefix):
            return "The power of attorney is valid for the period"
        case (.english, .bodyRevocationPrefix):
            return "The power of attorney may be revoked as follows"
        case (.english, .bodyThirdPartyNotice):
            return "Third parties may rely on the authority only within the scope set out in this document and under the Norwegian Contracts Act rules on authority."
        case (.english, .contactHeader):
            return "Contact details for the principal:"
        case (.english, .defaultRestrictions):
            return "The agent may not exceed what is expressly stated in this power of attorney."
        case (.english, .defaultValidity):
            return "from signing until revoked in writing"
        case (.english, .defaultRevocation):
            return "The power of attorney may be revoked at any time in writing by the principal. The revocation should be communicated to the agent and relevant third parties without undue delay."
        case (.thai, .cardSubtitle):
            return "จัดทำหนังสือมอบอำนาจอย่างเป็นทางการพร้อมผู้มอบอำนาจ ผู้รับมอบอำนาจ ขอบเขต และระยะเวลา"
        case (.thai, .legalChecklistTitle):
            return "สิ่งที่ควรระบุให้ชัดในหนังสือมอบอำนาจ"
        case (.thai, .principalTitle):
            return "ผู้มอบอำนาจ"
        case (.thai, .agentTitle):
            return "ผู้รับมอบอำนาจ"
        case (.thai, .mandateTitle):
            return "ขอบเขตและระยะเวลา"
        case (.thai, .purposeField):
            return "หนังสือมอบอำนาจนี้มีวัตถุประสงค์เพื่ออะไร"
        case (.thai, .scopeField):
            return "หนังสือมอบอำนาจนี้ครอบคลุมเรื่องใด"
        case (.thai, .restrictionsField):
            return "ข้อจำกัดหรือข้อสงวน"
        case (.thai, .validFromField):
            return "มีผลตั้งแต่"
        case (.thai, .validUntilField):
            return "มีผลถึง"
        case (.thai, .revocationField):
            return "จะเพิกถอนหนังสือมอบอำนาจนี้อย่างไร"
        case (.thai, .previewButton):
            return "แสดงหนังสือมอบอำนาจ"
        case (.thai, .blockingPrincipal):
            return "ผู้มอบอำนาจต้องมีชื่อและที่อยู่"
        case (.thai, .blockingAgent):
            return "ผู้รับมอบอำนาจต้องมีชื่อและที่อยู่"
        case (.thai, .blockingScope):
            return "ต้องอธิบายขอบเขตของอำนาจที่มอบ"
        case (.thai, .blockingPurpose):
            return "ต้องอธิบายวัตถุประสงค์ของหนังสือมอบอำนาจ"
        case (.thai, .blockingPlace):
            return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningDuration):
            return "ยังไม่ได้ระบุระยะเวลาที่มีผล ควรระบุให้ชัดว่าอำนาจนี้ใช้ได้นานเพียงใด"
        case (.thai, .warningRestrictions):
            return "ช่องข้อจำกัดยังว่าง หากอำนาจนี้ไม่ใช่อำนาจทั่วไป ควรระบุขอบเขตให้ชัดเจน"
        case (.thai, .warningRevocation):
            return "ยังไม่ได้ระบุวิธีเพิกถอน ควรระบุให้ชัดว่าสามารถถอนอำนาจได้อย่างไรและมีผลเมื่อใด"
        case (.thai, .clauseOneTitle):
            return "1. ผู้มอบอำนาจและผู้รับมอบอำนาจ"
        case (.thai, .clauseTwoTitle):
            return "2. วัตถุประสงค์"
        case (.thai, .clauseThreeTitle):
            return "3. ขอบเขต"
        case (.thai, .clauseFourTitle):
            return "4. ข้อจำกัด"
        case (.thai, .clauseFiveTitle):
            return "5. ระยะเวลามีผล"
        case (.thai, .clauseSixTitle):
            return "6. การเพิกถอน"
        case (.thai, .bodyIntroPrefix):
            return "ข้าพเจ้า"
        case (.thai, .bodyIntroMiddle):
            return "ขอมอบอำนาจให้"
        case (.thai, .bodyIntroSuffix):
            return "ดำเนินการแทนข้าพเจ้า"
        case (.thai, .bodyPurposePrefix):
            return "หนังสือมอบอำนาจนี้จัดทำขึ้นเพื่อวัตถุประสงค์ดังต่อไปนี้"
        case (.thai, .bodyScopePrefix):
            return "หนังสือมอบอำนาจนี้ครอบคลุม"
        case (.thai, .bodyRestrictionsPrefix):
            return "มีข้อจำกัดดังต่อไปนี้:"
        case (.thai, .bodyValidityPrefix):
            return "หนังสือมอบอำนาจนี้มีผลในช่วงเวลา"
        case (.thai, .bodyRevocationPrefix):
            return "หนังสือมอบอำนาจนี้สามารถเพิกถอนได้ดังนี้"
        case (.thai, .bodyThirdPartyNotice):
            return "บุคคลภายนอกอาจอาศัยหนังสือมอบอำนาจนี้ได้เฉพาะภายในขอบเขตที่ระบุไว้ในเอกสารนี้และตามกฎเรื่องตัวแทนในกฎหมายสัญญาของนอร์เวย์"
        case (.thai, .contactHeader):
            return "ข้อมูลติดต่อของผู้มอบอำนาจ:"
        case (.thai, .defaultRestrictions):
            return "ผู้รับมอบอำนาจต้องไม่กระทำเกินกว่าที่ระบุไว้อย่างชัดแจ้งในหนังสือมอบอำนาจนี้"
        case (.thai, .defaultValidity):
            return "ตั้งแต่วันลงนามจนกว่าจะมีการเพิกถอนเป็นลายลักษณ์อักษร"
        case (.thai, .defaultRevocation):
            return "ผู้มอบอำนาจสามารถเพิกถอนหนังสือมอบอำนาจนี้ได้ทุกเมื่อโดยทำเป็นลายลักษณ์อักษร และควรแจ้งผู้รับมอบอำนาจรวมถึงบุคคลภายนอกที่เกี่ยวข้องโดยไม่ชักช้า"
        }
    }
}

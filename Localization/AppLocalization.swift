//
//  AppLocalization.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case norwegian
    case english
    case thai

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .norwegian:
            return "Norsk"
        case .english:
            return "English"
        case .thai:
            return "ไทย"
        }
    }

    func text(_ key: LocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .language):
            return "Språk"
        case (.norwegian, .appTitle):
            return "LexWriter"
        case (.norwegian, .heroTitle):
            return "Dokumenter med preg av lov og rett"
        case (.norwegian, .heroSubtitle):
            return "Velg dokumenttype og fyll inn nødvendige opplysninger i en rolig, formell og utskriftsvennlig arbeidsflate."
        case (.norwegian, .documents):
            return "Dokumenter"
        case (.norwegian, .testamentTitle):
            return "Testament"
        case (.norwegian, .testamentSubtitle):
            return "Lag et juridisk strukturert testamentutkast med vitnefelt og utskrift."
        case (.norwegian, .contractTitle):
            return "Kontrakt"
        case (.norwegian, .purchaseAgreementTitle):
            return "Kjøpskontrakt"
        case (.norwegian, .rentalTerminationTitle):
            return "Oppsigelse av leieforhold"
        case (.norwegian, .receiptTitle):
            return "Kvittering"
        case (.norwegian, .loanAgreementTitle):
            return "Låneavtale"
        case (.norwegian, .employmentAgreementTitle):
            return "Arbeidsavtale"
        case (.norwegian, .ndaTitle):
            return "NDA"
        case (.norwegian, .powerOfAttorneyTitle):
            return "Fullmakt"
        case (.norwegian, .settings):
            return "Innstillinger"
        case (.norwegian, .help):
            return "Hjelp"
        case (.norwegian, .userGuide):
            return "Brukerveiledning"
        case (.norwegian, .appearance):
            return "Utseende"
        case (.norwegian, .appInfo):
            return "Appinformasjon"
        case (.norwegian, .version):
            return "Versjon"
        case (.norwegian, .build):
            return "Build"
        case (.norwegian, .versionAndBuild):
            return "Versjon og build"
        case (.norwegian, .systemMode):
            return "System"
        case (.norwegian, .lightMode):
            return "Lys"
        case (.norwegian, .darkMode):
            return "Mørk"
        case (.norwegian, .accessPlan):
            return "Tilgang"
        case (.norwegian, .currentEdition):
            return "Nåværende utgave"
        case (.norwegian, .fullEdition):
            return "Full tilgang"
        case (.norwegian, .futurePricingNote):
            return "Alle dokumenter er tilgjengelige nå. Gratis- og premium-inndeling er forberedt i kodebasen for senere bruk."
        case (.norwegian, .freeTier):
            return "Gratis"
        case (.norwegian, .premiumTier):
            return "Premium"
        case (.norwegian, .premiumTitle):
            return "LexWriter Premium"
        case (.norwegian, .premiumHeadline):
            return "Lås opp alle dokumentmaler"
        case (.norwegian, .premiumDescription):
            return "Premium gir tilgang til hele dokumentsamlingen og passer for brukere som trenger flere juridiske maler i samme app."
        case (.norwegian, .premiumIncludes):
            return "Premium inkluderer"
        case (.norwegian, .unlockPremiumLifetime):
            return "Lås opp livstidstilgang"
        case (.norwegian, .restorePurchases):
            return "Gjenopprett kjøp"
        case (.norwegian, .premiumUnlocked):
            return "Premium er aktivert."
        case (.norwegian, .premiumNotAvailableYet):
            return "Kjøpsproduktet er ikke koblet til ennå."
        case (.norwegian, .premiumDisclaimer):
            return "Betalt funksjonalitet kan aktiveres senere. Frem til da kan denne løsningen brukes for intern testing og videre klargjøring."
        case (.norwegian, .selectedPremiumDocument):
            return "Valgt dokument"
        case (.norwegian, .premiumRequiredShort):
            return "Krever premium"
        case (.norwegian, .premiumBenefitsTitle):
            return "Hvorfor premium"
        case (.norwegian, .premiumBenefitOne):
            return "Tilgang til alle avanserte dokumentmaler i én samlet app."
        case (.norwegian, .premiumBenefitTwo):
            return "Bedre verdi for brukere som trenger flere juridiske dokumenter over tid."
        case (.norwegian, .premiumBenefitThree):
            return "Enklere fremtidig oppgradering med livstidstilgang i stedet for abonnement."
        case (.norwegian, .premiumTestingNote):
            return "Dette er en testklar premiumvisning for simulator og intern validering."
        case (.norwegian, .premiumTesting):
            return "Premium testing"
        case (.norwegian, .lockPremiumDocuments):
            return "Lås premium-dokumenter"
        case (.norwegian, .openPremiumPreview):
            return "Åpne premiumvisning"
        case (.norwegian, .premiumProductIdentifier):
            return "Produkt-ID"
        case (.norwegian, .comingSoon):
            return "Kommer senere"
        case (.norwegian, .signingRequirements):
            return "Formkrav for gyldig testament"
        case (.norwegian, .mustFillIn):
            return "Dette må du fylle inn"
        case (.norwegian, .legalWarnings):
            return "Juridiske advarsler før utskrift"
        case (.norwegian, .aboutYou):
            return "Om deg"
        case (.norwegian, .familySituation):
            return "Familiesituasjon"
        case (.norwegian, .beneficiaries):
            return "Arvinger og disposisjoner"
        case (.norwegian, .residueAndProvisions):
            return "Restarv og særbestemmelser"
        case (.norwegian, .dateAndPlace):
            return "Dato og sted"
        case (.norwegian, .beforeSigning):
            return "Før signering"
        case (.norwegian, .witnesses):
            return "Vitner"
        case (.norwegian, .print):
            return "Utskrift"
        case (.norwegian, .important):
            return "Viktig"
        case (.norwegian, .showWill):
            return "Vis testament"
        case (.norwegian, .previewTitle):
            return "Utskriftsvisning"
        case (.norwegian, .close):
            return "Lukk"
        case (.norwegian, .printButton):
            return "Skriv ut"
        case (.norwegian, .savePDFButton):
            return "Lagre PDF"
        case (.norwegian, .legalWarningsTitle):
            return "Juridiske advarsler"
        case (.norwegian, .showAnyway):
            return "Vis likevel"
        case (.norwegian, .cancel):
            return "Avbryt"
        case (.norwegian, .fillAllRequired):
            return "Fyll inn alle påkrevde data og vitneopplysninger før testamentet kan vises."
        case (.norwegian, .witnessesPaperNotice):
            return "Vitnene signerer på papir. Feltene under brukes for å gjøre utskriften komplett."
        case (.norwegian, .importantNotice):
            return "Dette er et testamentutkast med norske formkrav. Ved store verdier, konflikt i familien, særkullsbarn, utenlandsk tilknytning eller komplekse disposisjoner bør advokat kontrollere teksten før signering."
        case (.norwegian, .signingNoticeOne):
            return "Jeg forstår at testator må underskrive eller vedkjenne seg testamentet mens begge vitnene er til stede samtidig."
        case (.norwegian, .signingNoticeTwo):
            return "Jeg forstår at vitnene må vite at dokumentet er et testament."
        case (.norwegian, .signingNoticeThree):
            return "Jeg forstår at vitnene må være habile og ikke selv være begunstiget eller nærstående til begunstigede."
        case (.norwegian, .addBeneficiary):
            return "Legg til arving"
        case (.norwegian, .removeBeneficiary):
            return "Fjern arving"
        case (.norwegian, .witnessOne):
            return "Vitne 1"
        case (.norwegian, .witnessTwo):
            return "Vitne 2"
        case (.norwegian, .name):
            return "Navn"
        case (.norwegian, .address):
            return "Adresse"
        case (.norwegian, .phone):
            return "Telefon"
        case (.norwegian, .email):
            return "E-post"
        case (.norwegian, .fullName):
            return "Fullt navn"
        case (.norwegian, .place):
            return "Sted"
        case (.norwegian, .date):
            return "Dato"
        case (.norwegian, .beneficiaryName):
            return "Navn på arving"
        case (.norwegian, .beneficiaryDisposition):
            return "Hva skal denne personen arve?"
        case (.norwegian, .residuePlaceholder):
            return "Hvem skal arve resten av formuen?"
        case (.norwegian, .specialProvisionsPlaceholder):
            return "Særbestemmelser eller presiseringer"
        case (.norwegian, .childrenToggle):
            return "Jeg har barn / livsarvinger"
        case (.norwegian, .spouseToggle):
            return "Jeg har ektefelle eller registrert partner"
        case (.norwegian, .cohabitantToggle):
            return "Jeg har samboer med arverett"
        case (.norwegian, .signatureAndDate):
            return "Sted og dato"
        case (.norwegian, .testatorSignature):
            return "Testators underskrift"
        case (.norwegian, .witnessStatementTitle):
            return "Vitnepåtegning"
        case (.english, .language):
            return "Language"
        case (.english, .appTitle):
            return "LexWriter"
        case (.english, .heroTitle):
            return "Documents with a legal character"
        case (.english, .heroSubtitle):
            return "Choose a document type and enter the required details in a calm, formal, print-ready workspace."
        case (.english, .documents):
            return "Documents"
        case (.english, .testamentTitle):
            return "Will"
        case (.english, .testamentSubtitle):
            return "Prepare a structured will draft with witness fields and printing."
        case (.english, .contractTitle):
            return "Contract"
        case (.english, .purchaseAgreementTitle):
            return "Purchase Agreement"
        case (.english, .rentalTerminationTitle):
            return "Termination of Tenancy"
        case (.english, .receiptTitle):
            return "Receipt"
        case (.english, .loanAgreementTitle):
            return "Loan Agreement"
        case (.english, .employmentAgreementTitle):
            return "Employment Agreement"
        case (.english, .ndaTitle):
            return "NDA"
        case (.english, .powerOfAttorneyTitle):
            return "Power of Attorney"
        case (.english, .settings):
            return "Settings"
        case (.english, .help):
            return "Help"
        case (.english, .userGuide):
            return "User Guide"
        case (.english, .appearance):
            return "Appearance"
        case (.english, .appInfo):
            return "App information"
        case (.english, .version):
            return "Version"
        case (.english, .build):
            return "Build"
        case (.english, .versionAndBuild):
            return "Version and build"
        case (.english, .systemMode):
            return "System"
        case (.english, .lightMode):
            return "Light"
        case (.english, .darkMode):
            return "Dark"
        case (.english, .accessPlan):
            return "Access"
        case (.english, .currentEdition):
            return "Current edition"
        case (.english, .fullEdition):
            return "Full access"
        case (.english, .futurePricingNote):
            return "All documents are currently available. The free and premium split has been prepared in the codebase for later use."
        case (.english, .freeTier):
            return "Free"
        case (.english, .premiumTier):
            return "Premium"
        case (.english, .premiumTitle):
            return "LexWriter Premium"
        case (.english, .premiumHeadline):
            return "Unlock the full document library"
        case (.english, .premiumDescription):
            return "Premium gives access to the full document collection for users who need more legal templates in one app."
        case (.english, .premiumIncludes):
            return "Premium includes"
        case (.english, .unlockPremiumLifetime):
            return "Unlock lifetime access"
        case (.english, .restorePurchases):
            return "Restore purchases"
        case (.english, .premiumUnlocked):
            return "Premium is active."
        case (.english, .premiumNotAvailableYet):
            return "The purchase product is not connected yet."
        case (.english, .premiumDisclaimer):
            return "Paid functionality can be enabled later. Until then, this setup is suitable for internal testing and release preparation."
        case (.english, .selectedPremiumDocument):
            return "Selected"
        case (.english, .premiumRequiredShort):
            return "Premium required"
        case (.english, .premiumBenefitsTitle):
            return "Why premium"
        case (.english, .premiumBenefitOne):
            return "Access every advanced document template in one app."
        case (.english, .premiumBenefitTwo):
            return "Better value for users who need multiple legal documents over time."
        case (.english, .premiumBenefitThree):
            return "Cleaner future upgrade path with lifetime access instead of a subscription."
        case (.english, .premiumTestingNote):
            return "This premium screen is prepared for simulator testing and internal validation."
        case (.english, .premiumTesting):
            return "Premium testing"
        case (.english, .lockPremiumDocuments):
            return "Lock premium documents"
        case (.english, .openPremiumPreview):
            return "Open premium preview"
        case (.english, .premiumProductIdentifier):
            return "Product ID"
        case (.english, .comingSoon):
            return "Coming later"
        case (.english, .signingRequirements):
            return "Signing requirements for a valid will"
        case (.english, .mustFillIn):
            return "Required information"
        case (.english, .legalWarnings):
            return "Legal warnings before printing"
        case (.english, .aboutYou):
            return "About you"
        case (.english, .familySituation):
            return "Family situation"
        case (.english, .beneficiaries):
            return "Beneficiaries and dispositions"
        case (.english, .residueAndProvisions):
            return "Residual estate and special provisions"
        case (.english, .dateAndPlace):
            return "Date and place"
        case (.english, .beforeSigning):
            return "Before signing"
        case (.english, .witnesses):
            return "Witnesses"
        case (.english, .print):
            return "Print"
        case (.english, .important):
            return "Important"
        case (.english, .showWill):
            return "Show will"
        case (.english, .previewTitle):
            return "Print preview"
        case (.english, .close):
            return "Close"
        case (.english, .printButton):
            return "Print"
        case (.english, .savePDFButton):
            return "Save PDF"
        case (.english, .legalWarningsTitle):
            return "Legal warnings"
        case (.english, .showAnyway):
            return "Show anyway"
        case (.english, .cancel):
            return "Cancel"
        case (.english, .fillAllRequired):
            return "Fill in all required data and witness details before the will can be shown."
        case (.english, .witnessesPaperNotice):
            return "Witnesses sign on paper. The fields below make the printed document complete."
        case (.english, .importantNotice):
            return "This is a will draft based on Norwegian formal requirements. Where there are substantial assets, family conflict, children from previous relationships, foreign ties, or complex dispositions, a lawyer should review the text before signing."
        case (.english, .signingNoticeOne):
            return "I understand that the testator must sign or acknowledge the will while both witnesses are present at the same time."
        case (.english, .signingNoticeTwo):
            return "I understand that the witnesses must know the document is a will."
        case (.english, .signingNoticeThree):
            return "I understand that the witnesses must be eligible and not be beneficiaries or closely related to beneficiaries."
        case (.english, .addBeneficiary):
            return "Add beneficiary"
        case (.english, .removeBeneficiary):
            return "Remove beneficiary"
        case (.english, .witnessOne):
            return "Witness 1"
        case (.english, .witnessTwo):
            return "Witness 2"
        case (.english, .name):
            return "Name"
        case (.english, .address):
            return "Address"
        case (.english, .phone):
            return "Phone"
        case (.english, .email):
            return "Email"
        case (.english, .fullName):
            return "Full name"
        case (.english, .place):
            return "Place"
        case (.english, .date):
            return "Date"
        case (.english, .beneficiaryName):
            return "Beneficiary name"
        case (.english, .beneficiaryDisposition):
            return "What should this person inherit?"
        case (.english, .residuePlaceholder):
            return "Who should inherit the remainder of the estate?"
        case (.english, .specialProvisionsPlaceholder):
            return "Special provisions or clarifications"
        case (.english, .childrenToggle):
            return "I have children / lineal descendants"
        case (.english, .spouseToggle):
            return "I have a spouse or registered partner"
        case (.english, .cohabitantToggle):
            return "I have a cohabitant with inheritance rights"
        case (.english, .signatureAndDate):
            return "Place and date"
        case (.english, .testatorSignature):
            return "Testator's signature"
        case (.english, .witnessStatementTitle):
            return "Witness attestation"
        case (.thai, .language):
            return "ภาษา"
        case (.thai, .appTitle):
            return "LexWriter"
        case (.thai, .heroTitle):
            return "เอกสารในบรรยากาศแห่งกฎหมายและความยุติธรรม"
        case (.thai, .heroSubtitle):
            return "เลือกประเภทเอกสารและกรอกข้อมูลที่จำเป็นในหน้าทำงานที่เป็นทางการ สงบ และพร้อมพิมพ์"
        case (.thai, .documents):
            return "เอกสาร"
        case (.thai, .testamentTitle):
            return "พินัยกรรม"
        case (.thai, .testamentSubtitle):
            return "จัดทำร่างพินัยกรรมพร้อมช่องพยานและการพิมพ์"
        case (.thai, .contractTitle):
            return "สัญญา"
        case (.thai, .purchaseAgreementTitle):
            return "สัญญาซื้อขาย"
        case (.thai, .rentalTerminationTitle):
            return "หนังสือบอกเลิกสัญญาเช่า"
        case (.thai, .receiptTitle):
            return "ใบเสร็จรับเงิน"
        case (.thai, .loanAgreementTitle):
            return "สัญญาเงินกู้"
        case (.thai, .employmentAgreementTitle):
            return "สัญญาจ้างงาน"
        case (.thai, .ndaTitle):
            return "ข้อตกลงไม่เปิดเผยข้อมูล"
        case (.thai, .powerOfAttorneyTitle):
            return "หนังสือมอบอำนาจ"
        case (.thai, .settings):
            return "ตั้งค่า"
        case (.thai, .help):
            return "ช่วยเหลือ"
        case (.thai, .userGuide):
            return "คู่มือการใช้งาน"
        case (.thai, .appearance):
            return "ลักษณะการแสดงผล"
        case (.thai, .appInfo):
            return "ข้อมูลแอป"
        case (.thai, .version):
            return "เวอร์ชัน"
        case (.thai, .build):
            return "บิลด์"
        case (.thai, .versionAndBuild):
            return "เวอร์ชันและบิลด์"
        case (.thai, .systemMode):
            return "ระบบ"
        case (.thai, .lightMode):
            return "สว่าง"
        case (.thai, .darkMode):
            return "มืด"
        case (.thai, .accessPlan):
            return "การเข้าถึง"
        case (.thai, .currentEdition):
            return "รุ่นปัจจุบัน"
        case (.thai, .fullEdition):
            return "เข้าถึงเต็มรูปแบบ"
        case (.thai, .futurePricingNote):
            return "ขณะนี้เอกสารทั้งหมดใช้งานได้ และมีการเตรียมโครงสร้างฟรีและพรีเมียมไว้ในโค้ดแล้วสำหรับใช้งานภายหลัง"
        case (.thai, .freeTier):
            return "ฟรี"
        case (.thai, .premiumTier):
            return "พรีเมียม"
        case (.thai, .premiumTitle):
            return "LexWriter Premium"
        case (.thai, .premiumHeadline):
            return "ปลดล็อกคลังเอกสารทั้งหมด"
        case (.thai, .premiumDescription):
            return "พรีเมียมให้สิทธิ์เข้าถึงชุดเอกสารทั้งหมดสำหรับผู้ใช้ที่ต้องการเทมเพลตกฎหมายมากขึ้นในแอปเดียว"
        case (.thai, .premiumIncludes):
            return "พรีเมียมประกอบด้วย"
        case (.thai, .unlockPremiumLifetime):
            return "ปลดล็อกการเข้าถึงตลอดชีพ"
        case (.thai, .restorePurchases):
            return "กู้คืนการซื้อ"
        case (.thai, .premiumUnlocked):
            return "เปิดใช้พรีเมียมแล้ว"
        case (.thai, .premiumNotAvailableYet):
            return "ยังไม่ได้เชื่อมต่อสินค้าสำหรับการซื้อ"
        case (.thai, .premiumDisclaimer):
            return "สามารถเปิดใช้ฟังก์ชันแบบชำระเงินได้ภายหลัง ระหว่างนี้โครงสร้างนี้เหมาะสำหรับการทดสอบภายในและการเตรียมปล่อยแอป"
        case (.thai, .selectedPremiumDocument):
            return "เอกสารที่เลือก"
        case (.thai, .premiumRequiredShort):
            return "ต้องใช้พรีเมียม"
        case (.thai, .premiumBenefitsTitle):
            return "เหตุผลที่ควรใช้พรีเมียม"
        case (.thai, .premiumBenefitOne):
            return "เข้าถึงเทมเพลตเอกสารขั้นสูงทั้งหมดได้ในแอปเดียว"
        case (.thai, .premiumBenefitTwo):
            return "คุ้มค่าสำหรับผู้ใช้ที่ต้องการเอกสารกฎหมายหลายประเภทในระยะยาว"
        case (.thai, .premiumBenefitThree):
            return "รองรับการอัปเกรดแบบตลอดชีพในอนาคตได้ง่ายกว่าแบบสมัครสมาชิก"
        case (.thai, .premiumTestingNote):
            return "หน้าพรีเมียมนี้พร้อมสำหรับการทดสอบบนซิมูเลเตอร์และการตรวจสอบภายใน"
        case (.thai, .premiumTesting):
            return "การทดสอบพรีเมียม"
        case (.thai, .lockPremiumDocuments):
            return "ล็อกเอกสารพรีเมียม"
        case (.thai, .openPremiumPreview):
            return "เปิดหน้าพรีเมียม"
        case (.thai, .premiumProductIdentifier):
            return "รหัสสินค้า"
        case (.thai, .comingSoon):
            return "จะเพิ่มภายหลัง"
        case (.thai, .signingRequirements):
            return "ข้อกำหนดในการลงนามเพื่อให้พินัยกรรมมีผล"
        case (.thai, .mustFillIn):
            return "ข้อมูลที่ต้องกรอก"
        case (.thai, .legalWarnings):
            return "คำเตือนทางกฎหมายก่อนพิมพ์"
        case (.thai, .aboutYou):
            return "ข้อมูลของคุณ"
        case (.thai, .familySituation):
            return "สถานะครอบครัว"
        case (.thai, .beneficiaries):
            return "ผู้รับมรดกและรายการทรัพย์สิน"
        case (.thai, .residueAndProvisions):
            return "ทรัพย์สินส่วนที่เหลือและข้อกำหนดพิเศษ"
        case (.thai, .dateAndPlace):
            return "วันที่และสถานที่"
        case (.thai, .beforeSigning):
            return "ก่อนลงนาม"
        case (.thai, .witnesses):
            return "พยาน"
        case (.thai, .print):
            return "พิมพ์"
        case (.thai, .important):
            return "สำคัญ"
        case (.thai, .showWill):
            return "แสดงพินัยกรรม"
        case (.thai, .previewTitle):
            return "ตัวอย่างก่อนพิมพ์"
        case (.thai, .close):
            return "ปิด"
        case (.thai, .printButton):
            return "พิมพ์"
        case (.thai, .savePDFButton):
            return "บันทึก PDF"
        case (.thai, .legalWarningsTitle):
            return "คำเตือนทางกฎหมาย"
        case (.thai, .showAnyway):
            return "แสดงต่อ"
        case (.thai, .cancel):
            return "ยกเลิก"
        case (.thai, .fillAllRequired):
            return "กรอกข้อมูลที่จำเป็นและรายละเอียดพยานให้ครบก่อนแสดงพินัยกรรม"
        case (.thai, .witnessesPaperNotice):
            return "พยานลงนามบนกระดาษ ช่องด้านล่างใช้เพื่อให้เอกสารพิมพ์สมบูรณ์"
        case (.thai, .importantNotice):
            return "นี่คือร่างพินัยกรรมตามข้อกำหนดทางรูปแบบของนอร์เวย์ หากมีทรัพย์สินจำนวนมาก ความขัดแย้งในครอบครัว บุตรต่างมารดา/บิดา ความเกี่ยวข้องกับต่างประเทศ หรือข้อกำหนดที่ซับซ้อน ควรให้ทนายตรวจทานก่อนลงนาม"
        case (.thai, .signingNoticeOne):
            return "ฉันเข้าใจว่าผู้ทำพินัยกรรมต้องลงนามหรือรับรองพินัยกรรมต่อหน้าพยานทั้งสองคนพร้อมกัน"
        case (.thai, .signingNoticeTwo):
            return "ฉันเข้าใจว่าพยานต้องทราบว่าเอกสารนี้คือพินัยกรรม"
        case (.thai, .signingNoticeThree):
            return "ฉันเข้าใจว่าพยานต้องมีคุณสมบัติเหมาะสมและต้องไม่เป็นผู้รับมรดกหรือญาติใกล้ชิดของผู้รับมรดก"
        case (.thai, .addBeneficiary):
            return "เพิ่มผู้รับมรดก"
        case (.thai, .removeBeneficiary):
            return "ลบผู้รับมรดก"
        case (.thai, .witnessOne):
            return "พยาน 1"
        case (.thai, .witnessTwo):
            return "พยาน 2"
        case (.thai, .name):
            return "ชื่อ"
        case (.thai, .address):
            return "ที่อยู่"
        case (.thai, .phone):
            return "โทรศัพท์"
        case (.thai, .email):
            return "อีเมล"
        case (.thai, .fullName):
            return "ชื่อเต็ม"
        case (.thai, .place):
            return "สถานที่"
        case (.thai, .date):
            return "วันที่"
        case (.thai, .beneficiaryName):
            return "ชื่อผู้รับมรดก"
        case (.thai, .beneficiaryDisposition):
            return "บุคคลนี้ควรได้รับมรดกอะไร"
        case (.thai, .residuePlaceholder):
            return "ใครควรได้รับทรัพย์สินส่วนที่เหลือ"
        case (.thai, .specialProvisionsPlaceholder):
            return "ข้อกำหนดพิเศษหรือคำชี้แจง"
        case (.thai, .childrenToggle):
            return "ฉันมีบุตร / ผู้สืบสันดาน"
        case (.thai, .spouseToggle):
            return "ฉันมีคู่สมรสหรือคู่จดทะเบียน"
        case (.thai, .cohabitantToggle):
            return "ฉันมีคู่ชีวิตที่มีสิทธิรับมรดก"
        case (.thai, .signatureAndDate):
            return "สถานที่และวันที่"
        case (.thai, .testatorSignature):
            return "ลายมือชื่อผู้ทำพินัยกรรม"
        case (.thai, .witnessStatementTitle):
            return "คำรับรองของพยาน"
        }
    }
}

enum LocalizedKey {
    case language
    case appTitle
    case heroTitle
    case heroSubtitle
    case documents
    case testamentTitle
    case testamentSubtitle
    case contractTitle
    case purchaseAgreementTitle
    case rentalTerminationTitle
    case receiptTitle
    case loanAgreementTitle
    case employmentAgreementTitle
    case ndaTitle
    case powerOfAttorneyTitle
    case settings
    case help
    case userGuide
    case appearance
    case appInfo
    case version
    case build
    case versionAndBuild
    case systemMode
    case lightMode
    case darkMode
    case accessPlan
    case currentEdition
    case fullEdition
    case futurePricingNote
    case freeTier
    case premiumTier
    case premiumTitle
    case premiumHeadline
    case premiumDescription
    case premiumIncludes
    case unlockPremiumLifetime
    case restorePurchases
    case premiumUnlocked
    case premiumNotAvailableYet
    case premiumDisclaimer
    case selectedPremiumDocument
    case premiumRequiredShort
    case premiumBenefitsTitle
    case premiumBenefitOne
    case premiumBenefitTwo
    case premiumBenefitThree
    case premiumTestingNote
    case premiumTesting
    case lockPremiumDocuments
    case openPremiumPreview
    case premiumProductIdentifier
    case comingSoon
    case signingRequirements
    case mustFillIn
    case legalWarnings
    case aboutYou
    case familySituation
    case beneficiaries
    case residueAndProvisions
    case dateAndPlace
    case beforeSigning
    case witnesses
    case print
    case important
    case showWill
    case previewTitle
    case close
    case printButton
    case savePDFButton
    case legalWarningsTitle
    case showAnyway
    case cancel
    case fillAllRequired
    case witnessesPaperNotice
    case importantNotice
    case signingNoticeOne
    case signingNoticeTwo
    case signingNoticeThree
    case addBeneficiary
    case removeBeneficiary
    case witnessOne
    case witnessTwo
    case name
    case address
    case phone
    case email
    case fullName
    case place
    case date
    case beneficiaryName
    case beneficiaryDisposition
    case residuePlaceholder
    case specialProvisionsPlaceholder
    case childrenToggle
    case spouseToggle
    case cohabitantToggle
    case signatureAndDate
    case testatorSignature
    case witnessStatementTitle
}

enum TestamentLocalizedKey {
    case signingRequirementOne
    case signingRequirementTwo
    case signingRequirementThree
    case signingRequirementFour
    case completionRequirementOne
    case completionRequirementTwo
    case completionRequirementThree
    case completionRequirementFour
    case completionRequirementFive
    case completionRequirementSix
    case blockingMissingName
    case blockingMissingAddress
    case blockingMissingBeneficiary
    case blockingMissingPlace
    case blockingMissingConfirmations
    case blockingMissingWitnesses
    case blockingWitnessOneIsTestator
    case blockingWitnessTwoIsTestator
    case blockingWitnessesMustDiffer
    case blockingWitnessOneIsBeneficiary
    case blockingWitnessTwoIsBeneficiary
    case warningChildren
    case warningSpouse
    case warningCohabitant
    case warningResidue
}

extension AppLanguage {
    func premiumMessage(for document: AppDocument) -> String {
        switch self {
        case .norwegian:
            return "\(document.title(for: self)) er del av premiumsamlingen. Lås opp livstidstilgang for å åpne dette dokumentet når premium aktiveres."
        case .english:
            return "\(document.title(for: self)) is part of the premium collection. Unlock lifetime access to open this document when premium is enabled."
        case .thai:
            return "\(document.title(for: self)) เป็นส่วนหนึ่งของชุดพรีเมียม ปลดล็อกการเข้าถึงตลอดชีพเพื่อเปิดเอกสารนี้เมื่อเปิดใช้พรีเมียม"
        }
    }

    func testamentText(_ key: TestamentLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .signingRequirementOne):
            return "Testator må underskrive eller vedkjenne seg testamentet mens to vitner er til stede samtidig."
        case (.norwegian, .signingRequirementTwo):
            return "Vitnene må vite at dokumentet er et testament."
        case (.norwegian, .signingRequirementThree):
            return "Vitnene må ha fylt 18 år og må ikke være begunstiget i testamentet eller nærstående til begunstigede."
        case (.norwegian, .signingRequirementFour):
            return "Testamentet må respektere arvelovens regler om pliktdelsarv og andre ufravikelige rettigheter."
        case (.norwegian, .completionRequirementOne):
            return "Fullt navn på testator"
        case (.norwegian, .completionRequirementTwo):
            return "Adresse til testator"
        case (.norwegian, .completionRequirementThree):
            return "Minst én arving med tydelig disposisjon"
        case (.norwegian, .completionRequirementFour):
            return "Sted for signering"
        case (.norwegian, .completionRequirementFive):
            return "Bekreftelser om signering og vitnekrav"
        case (.norwegian, .completionRequirementSix):
            return "Navn og adresse for to vitner"
        case (.norwegian, .blockingMissingName):
            return "Fullt navn på testator mangler."
        case (.norwegian, .blockingMissingAddress):
            return "Adresse til testator mangler."
        case (.norwegian, .blockingMissingBeneficiary):
            return "Minst én arving med konkret disposisjon må fylles inn."
        case (.norwegian, .blockingMissingPlace):
            return "Sted for signering mangler."
        case (.norwegian, .blockingMissingConfirmations):
            return "Bekreftelsene om signering og vitnekrav må krysses av før utskrift."
        case (.norwegian, .blockingMissingWitnesses):
            return "Begge vitner må ha navn og adresse fylt inn."
        case (.norwegian, .blockingWitnessOneIsTestator):
            return "Vitne 1 kan ikke være testator."
        case (.norwegian, .blockingWitnessTwoIsTestator):
            return "Vitne 2 kan ikke være testator."
        case (.norwegian, .blockingWitnessesMustDiffer):
            return "Vitne 1 og vitne 2 må være to forskjellige personer."
        case (.norwegian, .blockingWitnessOneIsBeneficiary):
            return "Vitne 1 kan ikke stå som arving i testamentet."
        case (.norwegian, .blockingWitnessTwoIsBeneficiary):
            return "Vitne 2 kan ikke stå som arving i testamentet."
        case (.norwegian, .warningChildren):
            return "Du har oppgitt barn/livsarvinger. Etter arveloven § 50 er to tredeler av formuen pliktdelsarv for livsarvingene, så disposisjonene må kontrolleres mot dette."
        case (.norwegian, .warningSpouse):
            return "Du har oppgitt ektefelle eller registrert partner. Testamentet må respektere ektefellens lovbestemte arverett og minstearv etter arveloven."
        case (.norwegian, .warningCohabitant):
            return "Du har oppgitt samboer med arverett. Testamentet må vurderes opp mot samboerens lovbestemte rettigheter etter arveloven."
        case (.norwegian, .warningResidue):
            return "Du har ikke fylt inn restarv eller særbestemmelser. Resterende arv fordeles da etter arvelovens regler."
        case (.english, .signingRequirementOne):
            return "The testator must sign or acknowledge the will while two witnesses are present at the same time."
        case (.english, .signingRequirementTwo):
            return "The witnesses must know that the document is a will."
        case (.english, .signingRequirementThree):
            return "The witnesses must be at least 18 years old and cannot be beneficiaries or closely related to beneficiaries."
        case (.english, .signingRequirementFour):
            return "The will must respect mandatory inheritance rules, including forced heirship and other non-derogable rights."
        case (.english, .completionRequirementOne):
            return "Full name of the testator"
        case (.english, .completionRequirementTwo):
            return "Address of the testator"
        case (.english, .completionRequirementThree):
            return "At least one beneficiary with a clear disposition"
        case (.english, .completionRequirementFour):
            return "Place of signing"
        case (.english, .completionRequirementFive):
            return "Confirmations about signing and witness requirements"
        case (.english, .completionRequirementSix):
            return "Name and address for two witnesses"
        case (.english, .blockingMissingName):
            return "The full name of the testator is missing."
        case (.english, .blockingMissingAddress):
            return "The address of the testator is missing."
        case (.english, .blockingMissingBeneficiary):
            return "At least one beneficiary with a specific disposition must be entered."
        case (.english, .blockingMissingPlace):
            return "The place of signing is missing."
        case (.english, .blockingMissingConfirmations):
            return "The signing and witness confirmations must be checked before printing."
        case (.english, .blockingMissingWitnesses):
            return "Both witnesses must have their name and address filled in."
        case (.english, .blockingWitnessOneIsTestator):
            return "Witness 1 cannot be the testator."
        case (.english, .blockingWitnessTwoIsTestator):
            return "Witness 2 cannot be the testator."
        case (.english, .blockingWitnessesMustDiffer):
            return "Witness 1 and witness 2 must be two different people."
        case (.english, .blockingWitnessOneIsBeneficiary):
            return "Witness 1 cannot also be listed as a beneficiary in the will."
        case (.english, .blockingWitnessTwoIsBeneficiary):
            return "Witness 2 cannot also be listed as a beneficiary in the will."
        case (.english, .warningChildren):
            return "You indicated that you have children or lineal descendants. Under the Norwegian Inheritance Act section 50, two thirds of the estate is reserved for them, so the dispositions must be checked against that rule."
        case (.english, .warningSpouse):
            return "You indicated that you have a spouse or registered partner. The will must respect the spouse's statutory inheritance rights and minimum inheritance."
        case (.english, .warningCohabitant):
            return "You indicated that you have a cohabitant with inheritance rights. The will should be assessed against the cohabitant's statutory rights under Norwegian law."
        case (.english, .warningResidue):
            return "You have not entered any residual estate clause or special provisions. Any remaining estate will then be distributed under the default inheritance rules."
        case (.thai, .signingRequirementOne):
            return "ผู้ทำพินัยกรรมต้องลงนามหรือรับรองพินัยกรรมในขณะที่พยานสองคนอยู่พร้อมกัน"
        case (.thai, .signingRequirementTwo):
            return "พยานต้องทราบว่าเอกสารนี้คือพินัยกรรม"
        case (.thai, .signingRequirementThree):
            return "พยานต้องมีอายุอย่างน้อย 18 ปี และต้องไม่เป็นผู้รับมรดกหรือญาติใกล้ชิดของผู้รับมรดก"
        case (.thai, .signingRequirementFour):
            return "พินัยกรรมต้องเคารพกฎมรดกภาคบังคับและสิทธิอื่นที่กฎหมายตัดทอนไม่ได้"
        case (.thai, .completionRequirementOne):
            return "ชื่อเต็มของผู้ทำพินัยกรรม"
        case (.thai, .completionRequirementTwo):
            return "ที่อยู่ของผู้ทำพินัยกรรม"
        case (.thai, .completionRequirementThree):
            return "ผู้รับมรดกอย่างน้อยหนึ่งคนพร้อมรายการทรัพย์สินที่ชัดเจน"
        case (.thai, .completionRequirementFour):
            return "สถานที่ลงนาม"
        case (.thai, .completionRequirementFive):
            return "การยืนยันเกี่ยวกับการลงนามและข้อกำหนดของพยาน"
        case (.thai, .completionRequirementSix):
            return "ชื่อและที่อยู่ของพยานสองคน"
        case (.thai, .blockingMissingName):
            return "ยังไม่ได้กรอกชื่อเต็มของผู้ทำพินัยกรรม"
        case (.thai, .blockingMissingAddress):
            return "ยังไม่ได้กรอกที่อยู่ของผู้ทำพินัยกรรม"
        case (.thai, .blockingMissingBeneficiary):
            return "ต้องกรอกผู้รับมรดกอย่างน้อยหนึ่งคนพร้อมรายละเอียดทรัพย์สินที่ชัดเจน"
        case (.thai, .blockingMissingPlace):
            return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .blockingMissingConfirmations):
            return "ต้องทำเครื่องหมายยืนยันเรื่องการลงนามและข้อกำหนดของพยานก่อนพิมพ์"
        case (.thai, .blockingMissingWitnesses):
            return "พยานทั้งสองคนต้องกรอกชื่อและที่อยู่ให้ครบ"
        case (.thai, .blockingWitnessOneIsTestator):
            return "พยาน 1 ไม่สามารถเป็นผู้ทำพินัยกรรมได้"
        case (.thai, .blockingWitnessTwoIsTestator):
            return "พยาน 2 ไม่สามารถเป็นผู้ทำพินัยกรรมได้"
        case (.thai, .blockingWitnessesMustDiffer):
            return "พยาน 1 และพยาน 2 ต้องเป็นคนละคนกัน"
        case (.thai, .blockingWitnessOneIsBeneficiary):
            return "พยาน 1 ไม่สามารถเป็นผู้รับมรดกในพินัยกรรมนี้ได้"
        case (.thai, .blockingWitnessTwoIsBeneficiary):
            return "พยาน 2 ไม่สามารถเป็นผู้รับมรดกในพินัยกรรมนี้ได้"
        case (.thai, .warningChildren):
            return "คุณระบุว่ามีบุตรหรือผู้สืบสันดาน ตามกฎหมายมรดกนอร์เวย์มาตรา 50 ทรัพย์สินสองในสามเป็นส่วนบังคับของทายาทสายตรง จึงต้องตรวจสอบรายการที่ระบุไว้กับกฎนี้"
        case (.thai, .warningSpouse):
            return "คุณระบุว่ามีคู่สมรสหรือคู่จดทะเบียน พินัยกรรมต้องเคารพสิทธิรับมรดกตามกฎหมายและส่วนขั้นต่ำของคู่สมรส"
        case (.thai, .warningCohabitant):
            return "คุณระบุว่ามีคู่ชีวิตที่มีสิทธิรับมรดก ควรประเมินพินัยกรรมนี้เทียบกับสิทธิตามกฎหมายของคู่ชีวิตภายใต้กฎหมายนอร์เวย์"
        case (.thai, .warningResidue):
            return "คุณยังไม่ได้ระบุผู้รับทรัพย์สินส่วนที่เหลือหรือข้อกำหนดพิเศษ ทรัพย์สินที่เหลือจะถูกแบ่งตามกฎหมายมรดกโดยปริยาย"
        }
    }
}

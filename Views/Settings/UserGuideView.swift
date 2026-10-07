//
//  UserGuideView.swift
//  LexWriter
//
//  Created by Codex on 29/08/2026.
//

import SwiftUI

struct UserGuideView: View {
    let language: AppLanguage

    var body: some View {
        List {
            Section(language.guideText(.gettingStartedTitle)) {
                GuideTextBlock(text: language.guideText(.gettingStartedBody))
            }

            Section(language.guideText(.documentsTitle)) {
                GuideTextBlock(text: language.guideText(.documentsBody))
            }

            Section(language.guideText(.accessTitle)) {
                GuideTextBlock(text: language.guideText(.accessBody))
            }

            Section(language.guideText(.printingTitle)) {
                GuideTextBlock(text: language.guideText(.printingBody))
            }

            Section(language.guideText(.privacyTitle)) {
                GuideTextBlock(text: language.guideText(.privacyBody))
            }

            Section(language.guideText(.importantTitle)) {
                GuideTextBlock(text: language.guideText(.importantBody))
            }
        }
        .navigationTitle(language.text(.userGuide))
    }
}

private struct GuideTextBlock: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.body)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.vertical, 4)
    }
}

enum UserGuideLocalizedKey {
    case gettingStartedTitle
    case gettingStartedBody
    case documentsTitle
    case documentsBody
    case accessTitle
    case accessBody
    case printingTitle
    case printingBody
    case privacyTitle
    case privacyBody
    case importantTitle
    case importantBody
}

extension AppLanguage {
    func guideText(_ key: UserGuideLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .gettingStartedTitle):
            return "Kom i gang"
        case (.norwegian, .gettingStartedBody):
            return "Velg språk i innstillingene og åpne deretter dokumenttypen du vil opprette. Fyll inn feltene så konkret som mulig. Appen viser advarsler hvis viktig informasjon mangler før forhåndsvisning og utskrift."
        case (.norwegian, .documentsTitle):
            return "Dokumenttyper"
        case (.norwegian, .documentsBody):
            return "LexWriter støtter nå testament, kontrakt, fullmakt, husleiekontrakt, samboeravtale, gjeldsbrev, kjøpskontrakt, oppsigelse av leieforhold, kvittering, låneavtale, arbeidsavtale og NDA. Hver dokumenttype har egne felter som er tilpasset innholdet i akkurat den avtalen."
        case (.norwegian, .accessTitle):
            return "Gratis og premium"
        case (.norwegian, .accessBody):
            return "Dokumenter kan være merket som gratis eller premium. I denne utgaven er alle dokumenter fortsatt tilgjengelige, mens premium-inndelingen er forberedt for en senere betalt versjon."
        case (.norwegian, .printingTitle):
            return "Forhåndsvisning og utskrift"
        case (.norwegian, .printingBody):
            return "Når alle nødvendige felt er fylt inn, kan du åpne forhåndsvisning. Med språkknappen kan du velge norsk, engelsk, thai eller en tospråklig utgave før dokumentet skrives ut eller lagres som PDF. Faste overskrifter og standardtekster bytter språk, mens navn og tekst du selv har skrevet beholdes uendret. Kontroller derfor hele dokumentet før signering."
        case (.norwegian, .privacyTitle):
            return "Personvern"
        case (.norwegian, .privacyBody):
            return "Appen er laget for å fylle inn og skrive ut dokumenter uten at sensitive personopplysninger må lagres permanent. Du bør likevel være varsom med hvem som har tilgang til enheten og utskriftene dine."
        case (.norwegian, .importantTitle):
            return "Viktig juridisk merknad"
        case (.norwegian, .importantBody):
            return "Dokumentene er utkast og hjelpemidler. Ved store verdier, konflikt, barn, internasjonale forhold eller andre kompliserte spørsmål bør dokumentet gjennomgås av advokat eller annen kvalifisert rådgiver før signering."
        case (.english, .gettingStartedTitle):
            return "Getting Started"
        case (.english, .gettingStartedBody):
            return "Choose the language in Settings, then open the document type you want to prepare. Fill in the fields as specifically as possible. The app shows warnings if important information is missing before preview and printing."
        case (.english, .documentsTitle):
            return "Document Types"
        case (.english, .documentsBody):
            return "LexWriter currently supports wills, contracts, powers of attorney, rental agreements, cohabitation agreements, promissory notes, purchase agreements, termination of tenancy notices, receipts, loan agreements, employment agreements, and NDAs. Each document type has fields tailored to that specific legal document."
        case (.english, .accessTitle):
            return "Free and Premium"
        case (.english, .accessBody):
            return "Documents may be marked as free or premium. In this edition, all documents remain available while the premium split is prepared for a later paid version."
        case (.english, .printingTitle):
            return "Preview and Printing"
        case (.english, .printingBody):
            return "When all required fields are completed, you can open the preview. Use the language button to select Norwegian, English, Thai, or a bilingual edition before printing or saving a PDF. Standard headings and template text change language, while names and text you entered remain unchanged. Review the complete document before signing."
        case (.english, .privacyTitle):
            return "Privacy"
        case (.english, .privacyBody):
            return "The app is designed to fill in and print documents without requiring permanent storage of sensitive personal data. You should still be careful about who has access to your device and printed copies."
        case (.english, .importantTitle):
            return "Important Legal Note"
        case (.english, .importantBody):
            return "The documents are drafts and practical aids. Where there are substantial values, conflict, children, international ties, or other complex issues, the document should be reviewed by a lawyer or other qualified adviser before signing."
        case (.thai, .gettingStartedTitle):
            return "เริ่มต้นใช้งาน"
        case (.thai, .gettingStartedBody):
            return "เลือกภาษาในหน้าตั้งค่า จากนั้นเปิดประเภทเอกสารที่ต้องการจัดทำ กรอกข้อมูลให้เฉพาะเจาะจงมากที่สุด แอปจะแสดงคำเตือนหากข้อมูลสำคัญยังไม่ครบก่อนดูตัวอย่างและพิมพ์"
        case (.thai, .documentsTitle):
            return "ประเภทเอกสาร"
        case (.thai, .documentsBody):
            return "ขณะนี้ LexWriter รองรับพินัยกรรม สัญญา หนังสือมอบอำนาจ สัญญาเช่า สัญญาอยู่กินร่วมกัน หนังสือรับสภาพหนี้ สัญญาซื้อขาย หนังสือบอกเลิกสัญญาเช่า ใบเสร็จรับเงิน สัญญาเงินกู้ สัญญาจ้างงาน และ NDA โดยแต่ละประเภทมีช่องข้อมูลที่เหมาะกับเอกสารนั้นโดยเฉพาะ"
        case (.thai, .accessTitle):
            return "ฟรีและพรีเมียม"
        case (.thai, .accessBody):
            return "เอกสารอาจมีป้ายกำกับว่าฟรีหรือพรีเมียม ในเวอร์ชันนี้เอกสารทั้งหมดยังคงใช้งานได้ ขณะที่โครงสร้างพรีเมียมถูกเตรียมไว้สำหรับเวอร์ชันแบบชำระเงินในภายหลัง"
        case (.thai, .printingTitle):
            return "ตัวอย่างและการพิมพ์"
        case (.thai, .printingBody):
            return "เมื่อกรอกข้อมูลที่จำเป็นครบแล้ว คุณสามารถเปิดตัวอย่างได้ ใช้ปุ่มภาษาเพื่อเลือกภาษานอร์เวย์ อังกฤษ ไทย หรือฉบับสองภาษา ก่อนพิมพ์หรือบันทึกเป็น PDF หัวข้อและข้อความมาตรฐานจะเปลี่ยนภาษา แต่ชื่อและข้อความที่คุณกรอกเองจะคงเดิม ดังนั้นควรตรวจสอบเอกสารทั้งหมดก่อนลงนาม"
        case (.thai, .privacyTitle):
            return "ความเป็นส่วนตัว"
        case (.thai, .privacyBody):
            return "แอปนี้ออกแบบมาเพื่อกรอกและพิมพ์เอกสารโดยไม่จำเป็นต้องจัดเก็บข้อมูลส่วนบุคคลที่อ่อนไหวอย่างถาวร อย่างไรก็ตาม คุณควรระวังการเข้าถึงอุปกรณ์และสำเนาที่พิมพ์ออกมา"
        case (.thai, .importantTitle):
            return "หมายเหตุทางกฎหมายที่สำคัญ"
        case (.thai, .importantBody):
            return "เอกสารเหล่านี้เป็นเพียงร่างและเครื่องมือช่วย หากมีมูลค่าทรัพย์สินสูง มีข้อพิพาท มีบุตร มีความเกี่ยวข้องกับต่างประเทศ หรือมีประเด็นซับซ้อนอื่น ควรให้ทนายหรือผู้เชี่ยวชาญที่เหมาะสมตรวจทานก่อนลงนาม"
        }
    }
}

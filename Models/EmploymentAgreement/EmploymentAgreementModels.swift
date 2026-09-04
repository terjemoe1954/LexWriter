//
//  EmploymentAgreementModels.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import Foundation

enum EmploymentAgreementLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case employerTitle
    case employeeTitle
    case employmentTermsTitle
    case positionField
    case dutiesField
    case startDateField
    case workplaceField
    case salaryField
    case workingHoursField
    case probationField
    case terminationField
    case confidentialityField
    case previewButton
    case blockingEmployer
    case blockingEmployee
    case blockingPosition
    case blockingStartDate
    case blockingSalary
    case blockingPlace
    case warningDuties
    case warningHours
    case warningProbation
    case warningTermination
    case warningConfidentiality
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyPositionPrefix
    case bodyDutiesPrefix
    case bodyStartPrefix
    case bodyWorkplacePrefix
    case bodySalaryPrefix
    case bodyHoursPrefix
    case bodyProbationPrefix
    case bodyTerminationPrefix
    case bodyConfidentialityPrefix
    case bodyGoodFaith
    case defaultDuties
    case defaultHours
    case defaultProbation
    case defaultTermination
    case defaultConfidentiality
}

struct EmploymentAgreementFormData {
    var employer = ContractParty()
    var employee = ContractParty()
    var positionTitle = ""
    var duties = ""
    var startDate = ""
    var workplace = ""
    var salary = ""
    var workingHours = ""
    var probationPeriod = ""
    var terminationNotice = ""
    var confidentialityTerms = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if employer.name.trimmed.isEmpty || employer.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.employmentAgreementText(.blockingEmployer)))
        }
        if employee.name.trimmed.isEmpty || employee.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.employmentAgreementText(.blockingEmployee)))
        }
        if positionTitle.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.employmentAgreementText(.blockingPosition)))
        }
        if startDate.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.employmentAgreementText(.blockingStartDate)))
        }
        if salary.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.employmentAgreementText(.blockingSalary)))
        }
        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.employmentAgreementText(.blockingPlace)))
        }
        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if duties.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.employmentAgreementText(.warningDuties)))
        }
        if workingHours.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.employmentAgreementText(.warningHours)))
        }
        if probationPeriod.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.employmentAgreementText(.warningProbation)))
        }
        if terminationNotice.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.employmentAgreementText(.warningTermination)))
        }
        if confidentialityTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.employmentAgreementText(.warningConfidentiality)))
        }
        return messages
    }

    var document: EmploymentAgreementDocument {
        EmploymentAgreementDocument(
            employer: employer,
            employee: employee,
            positionTitle: positionTitle.trimmed,
            duties: duties.trimmed,
            startDate: startDate.trimmed,
            workplace: workplace.trimmed,
            salary: salary.trimmed,
            workingHours: workingHours.trimmed,
            probationPeriod: probationPeriod.trimmed,
            terminationNotice: terminationNotice.trimmed,
            confidentialityTerms: confidentialityTerms.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct EmploymentAgreementDocument {
    let employer: ContractParty
    let employee: ContractParty
    let positionTitle: String
    let duties: String
    let startDate: String
    let workplace: String
    let salary: String
    let workingHours: String
    let probationPeriod: String
    let terminationNotice: String
    let confidentialityTerms: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let dutiesText = duties.isEmpty ? language.employmentAgreementText(.defaultDuties) : duties
        let hoursText = workingHours.isEmpty ? language.employmentAgreementText(.defaultHours) : workingHours
        let probationText = probationPeriod.isEmpty ? language.employmentAgreementText(.defaultProbation) : probationPeriod
        let terminationText = terminationNotice.isEmpty ? language.employmentAgreementText(.defaultTermination) : terminationNotice
        let confidentialityText = confidentialityTerms.isEmpty ? language.employmentAgreementText(.defaultConfidentiality) : confidentialityTerms

        return [
            "\(language.employmentAgreementText(.clauseOneTitle))\n\(language.employmentAgreementText(.bodyPartiesPrefix)) \(employer.name.trimmed), \(employer.address.trimmed), \(language.employmentAgreementText(.bodyPartiesMiddle)) \(employee.name.trimmed), \(employee.address.trimmed).",
            "\(language.employmentAgreementText(.clauseTwoTitle))\n\(language.employmentAgreementText(.bodyPositionPrefix)) \(positionTitle).\n\(language.employmentAgreementText(.bodyDutiesPrefix)) \(dutiesText).",
            "\(language.employmentAgreementText(.clauseThreeTitle))\n\(language.employmentAgreementText(.bodyStartPrefix)) \(startDate).\n\(language.employmentAgreementText(.bodyWorkplacePrefix)) \(workplace.isEmpty ? "-" : workplace).",
            "\(language.employmentAgreementText(.clauseFourTitle))\n\(language.employmentAgreementText(.bodySalaryPrefix)) \(salary).\n\(language.employmentAgreementText(.bodyHoursPrefix)) \(hoursText).",
            "\(language.employmentAgreementText(.clauseFiveTitle))\n\(language.employmentAgreementText(.bodyProbationPrefix)) \(probationText).\n\(language.employmentAgreementText(.bodyTerminationPrefix)) \(terminationText).",
            "\(language.employmentAgreementText(.clauseSixTitle))\n\(language.employmentAgreementText(.bodyConfidentialityPrefix)) \(confidentialityText)",
            language.employmentAgreementText(.bodyGoodFaith)
        ].joined(separator: "\n\n")
    }

    func htmlDocument(in language: AppLanguage) -> String {
        """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body { font-family: Georgia, 'Times New Roman', serif; color: #2c2218; margin: 44px; line-height: 1.6; background: #fbf4e7; }
        h1 { text-align: center; letter-spacing: 3px; margin-bottom: 30px; }
        .paper { border: 1px solid #8d7358; padding: 36px; background: #f8efdd; }
        .line { border-bottom: 1px solid #4a3c2d; margin-top: 20px; padding-top: 20px; }
        .signature { margin-top: 44px; }
        </style>
        </head>
        <body>
        <div class="paper">
        <h1>\(language.employmentAgreementText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(employer.name.htmlEscaped)</div>
        <div class="line">\(employee.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var employmentAgreementChecklist: [String] {
        [
            employmentAgreementText(.bodyPositionPrefix),
            employmentAgreementText(.warningHours).replacingOccurrences(of: ".", with: ""),
            employmentAgreementText(.warningTermination).replacingOccurrences(of: ".", with: "")
        ]
    }

    func employmentAgreementText(_ key: EmploymentAgreementLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title): return "Arbeidsavtale"
        case (.norwegian, .cardSubtitle): return "Lag en enkel arbeidsavtale med stilling, lønn, arbeidstid og oppsigelse."
        case (.norwegian, .legalChecklistTitle): return "Det som bør være tydelig i arbeidsavtalen"
        case (.norwegian, .employerTitle): return "Arbeidsgiver"
        case (.norwegian, .employeeTitle): return "Arbeidstaker"
        case (.norwegian, .employmentTermsTitle): return "Arbeidsforhold"
        case (.norwegian, .positionField): return "Stilling eller rolle"
        case (.norwegian, .dutiesField): return "Arbeidsoppgaver"
        case (.norwegian, .startDateField): return "Oppstartsdato"
        case (.norwegian, .workplaceField): return "Arbeidssted"
        case (.norwegian, .salaryField): return "Lønn eller honorar"
        case (.norwegian, .workingHoursField): return "Arbeidstid"
        case (.norwegian, .probationField): return "Prøvetid"
        case (.norwegian, .terminationField): return "Oppsigelse og oppsigelsestid"
        case (.norwegian, .confidentialityField): return "Taushet eller konfidensialitet"
        case (.norwegian, .previewButton): return "Vis arbeidsavtale"
        case (.norwegian, .blockingEmployer): return "Arbeidsgiver må ha navn og adresse."
        case (.norwegian, .blockingEmployee): return "Arbeidstaker må ha navn og adresse."
        case (.norwegian, .blockingPosition): return "Stillingen eller rollen må beskrives."
        case (.norwegian, .blockingStartDate): return "Oppstartsdato må fylles inn."
        case (.norwegian, .blockingSalary): return "Lønn eller honorar må fylles inn."
        case (.norwegian, .blockingPlace): return "Sted for signering mangler."
        case (.norwegian, .warningDuties): return "Arbeidsoppgaver er ikke beskrevet. Det bør fremgå hva arbeidstakeren skal gjøre."
        case (.norwegian, .warningHours): return "Arbeidstid er ikke regulert. Det bør fremgå omfang, arbeidstid eller turnus."
        case (.norwegian, .warningProbation): return "Prøvetid er ikke omtalt. Det bør fremgå om det gjelder prøvetid og hvor lenge."
        case (.norwegian, .warningTermination): return "Oppsigelse er ikke regulert. Det bør fremgå oppsigelsestid eller hvordan avslutning håndteres."
        case (.norwegian, .warningConfidentiality): return "Konfidensialitet er ikke omtalt. Hvis arbeidstakeren får tilgang til sensitiv informasjon bør dette beskrives."
        case (.norwegian, .clauseOneTitle): return "1. Parter"
        case (.norwegian, .clauseTwoTitle): return "2. Stilling og oppgaver"
        case (.norwegian, .clauseThreeTitle): return "3. Oppstart og arbeidssted"
        case (.norwegian, .clauseFourTitle): return "4. Lønn og arbeidstid"
        case (.norwegian, .clauseFiveTitle): return "5. Prøvetid og oppsigelse"
        case (.norwegian, .clauseSixTitle): return "6. Taushet"
        case (.norwegian, .bodyPartiesPrefix): return "Mellom"
        case (.norwegian, .bodyPartiesMiddle): return "og"
        case (.norwegian, .bodyPositionPrefix): return "Arbeidstaker tiltrer som"
        case (.norwegian, .bodyDutiesPrefix): return "Arbeidsoppgavene omfatter"
        case (.norwegian, .bodyStartPrefix): return "Arbeidsforholdet starter"
        case (.norwegian, .bodyWorkplacePrefix): return "Arbeidssted er"
        case (.norwegian, .bodySalaryPrefix): return "Lønn eller honorar er satt til"
        case (.norwegian, .bodyHoursPrefix): return "Arbeidstid eller omfang er"
        case (.norwegian, .bodyProbationPrefix): return "Følgende gjelder om prøvetid"
        case (.norwegian, .bodyTerminationPrefix): return "Følgende gjelder om oppsigelse"
        case (.norwegian, .bodyConfidentialityPrefix): return "Følgende gjelder om taushet eller konfidensialitet"
        case (.norwegian, .bodyGoodFaith): return "Partene bekrefter at arbeidsavtalen er lest, forstått og inngått frivillig."
        case (.norwegian, .defaultDuties): return "Arbeidsoppgavene fastsettes nærmere av arbeidsgiver innenfor stillingens rammer."
        case (.norwegian, .defaultHours): return "Arbeidstid fastsettes etter nærmere plan eller avtale mellom partene."
        case (.norwegian, .defaultProbation): return "Ingen særskilt prøvetid er oppgitt i denne avtalen."
        case (.norwegian, .defaultTermination): return "Oppsigelse håndteres etter lov og skriftlig varsel mellom partene."
        case (.norwegian, .defaultConfidentiality): return "Arbeidstaker skal behandle interne opplysninger forsvarlig og ikke dele informasjon uten grunnlag."
        case (.english, .title): return "Employment Agreement"
        case (.english, .cardSubtitle): return "Prepare a simple employment agreement with role, pay, working hours, and termination."
        case (.english, .legalChecklistTitle): return "What should be clear in the employment agreement"
        case (.english, .employerTitle): return "Employer"
        case (.english, .employeeTitle): return "Employee"
        case (.english, .employmentTermsTitle): return "Employment terms"
        case (.english, .positionField): return "Position or role"
        case (.english, .dutiesField): return "Duties"
        case (.english, .startDateField): return "Start date"
        case (.english, .workplaceField): return "Workplace"
        case (.english, .salaryField): return "Salary or fee"
        case (.english, .workingHoursField): return "Working hours"
        case (.english, .probationField): return "Probation period"
        case (.english, .terminationField): return "Termination and notice"
        case (.english, .confidentialityField): return "Confidentiality"
        case (.english, .previewButton): return "Show employment agreement"
        case (.english, .blockingEmployer): return "The employer must have a name and address."
        case (.english, .blockingEmployee): return "The employee must have a name and address."
        case (.english, .blockingPosition): return "The position or role must be described."
        case (.english, .blockingStartDate): return "The start date must be entered."
        case (.english, .blockingSalary): return "The salary or fee must be entered."
        case (.english, .blockingPlace): return "The place of signing is missing."
        case (.english, .warningDuties): return "Duties are not described. It should be clear what the employee is expected to do."
        case (.english, .warningHours): return "Working hours are not regulated. It should be clear what scope, hours, or rota applies."
        case (.english, .warningProbation): return "Probation is not addressed. It should be clear whether a probation period applies and how long it is."
        case (.english, .warningTermination): return "Termination is not regulated. It should be clear what notice applies or how the relationship may end."
        case (.english, .warningConfidentiality): return "Confidentiality is not addressed. If the employee will access sensitive information, this should be described."
        case (.english, .clauseOneTitle): return "1. Parties"
        case (.english, .clauseTwoTitle): return "2. Position and duties"
        case (.english, .clauseThreeTitle): return "3. Start and workplace"
        case (.english, .clauseFourTitle): return "4. Pay and working hours"
        case (.english, .clauseFiveTitle): return "5. Probation and termination"
        case (.english, .clauseSixTitle): return "6. Confidentiality"
        case (.english, .bodyPartiesPrefix): return "Between"
        case (.english, .bodyPartiesMiddle): return "and"
        case (.english, .bodyPositionPrefix): return "The employee is engaged as"
        case (.english, .bodyDutiesPrefix): return "The duties include"
        case (.english, .bodyStartPrefix): return "The employment starts"
        case (.english, .bodyWorkplacePrefix): return "The workplace is"
        case (.english, .bodySalaryPrefix): return "Salary or fee is set at"
        case (.english, .bodyHoursPrefix): return "Working hours or scope are"
        case (.english, .bodyProbationPrefix): return "The following applies regarding probation"
        case (.english, .bodyTerminationPrefix): return "The following applies regarding termination"
        case (.english, .bodyConfidentialityPrefix): return "The following applies regarding confidentiality"
        case (.english, .bodyGoodFaith): return "The parties confirm that the employment agreement has been read, understood, and entered into voluntarily."
        case (.english, .defaultDuties): return "The duties will be specified further by the employer within the scope of the role."
        case (.english, .defaultHours): return "Working hours will be set by schedule or further agreement between the parties."
        case (.english, .defaultProbation): return "No separate probation period is stated in this agreement."
        case (.english, .defaultTermination): return "Termination will be handled according to law and written notice between the parties."
        case (.english, .defaultConfidentiality): return "The employee shall handle internal information responsibly and shall not share information without authority."
        case (.thai, .title): return "สัญญาจ้างงาน"
        case (.thai, .cardSubtitle): return "จัดทำสัญญาจ้างงานอย่างง่ายพร้อมตำแหน่ง ค่าจ้าง เวลาทำงาน และการเลิกจ้าง"
        case (.thai, .legalChecklistTitle): return "สิ่งที่ควรระบุให้ชัดในสัญญาจ้างงาน"
        case (.thai, .employerTitle): return "นายจ้าง"
        case (.thai, .employeeTitle): return "ลูกจ้าง"
        case (.thai, .employmentTermsTitle): return "เงื่อนไขการจ้าง"
        case (.thai, .positionField): return "ตำแหน่งหรือบทบาท"
        case (.thai, .dutiesField): return "หน้าที่งาน"
        case (.thai, .startDateField): return "วันเริ่มงาน"
        case (.thai, .workplaceField): return "สถานที่ทำงาน"
        case (.thai, .salaryField): return "เงินเดือนหรือค่าตอบแทน"
        case (.thai, .workingHoursField): return "เวลาทำงาน"
        case (.thai, .probationField): return "ระยะทดลองงาน"
        case (.thai, .terminationField): return "การเลิกจ้างและการบอกกล่าว"
        case (.thai, .confidentialityField): return "การรักษาความลับ"
        case (.thai, .previewButton): return "แสดงสัญญาจ้างงาน"
        case (.thai, .blockingEmployer): return "นายจ้างต้องมีชื่อและที่อยู่"
        case (.thai, .blockingEmployee): return "ลูกจ้างต้องมีชื่อและที่อยู่"
        case (.thai, .blockingPosition): return "ต้องอธิบายตำแหน่งหรือบทบาท"
        case (.thai, .blockingStartDate): return "ต้องกรอกวันเริ่มงาน"
        case (.thai, .blockingSalary): return "ต้องกรอกเงินเดือนหรือค่าตอบแทน"
        case (.thai, .blockingPlace): return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningDuties): return "ยังไม่ได้อธิบายหน้าที่งาน ควรระบุให้ชัดว่าลูกจ้างต้องทำอะไร"
        case (.thai, .warningHours): return "ยังไม่ได้กำหนดเวลาทำงาน ควรระบุชั่วโมงทำงานหรือขอบเขตงานให้ชัด"
        case (.thai, .warningProbation): return "ยังไม่ได้กล่าวถึงระยะทดลองงาน ควรระบุว่ามีหรือไม่มีและนานเท่าใด"
        case (.thai, .warningTermination): return "ยังไม่ได้กำหนดการเลิกจ้าง ควรระบุระยะเวลาบอกกล่าวหรือวิธีสิ้นสุดสัญญา"
        case (.thai, .warningConfidentiality): return "ยังไม่ได้กล่าวถึงการรักษาความลับ หากลูกจ้างเข้าถึงข้อมูลสำคัญควรระบุเรื่องนี้"
        case (.thai, .clauseOneTitle): return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle): return "2. ตำแหน่งและหน้าที่"
        case (.thai, .clauseThreeTitle): return "3. การเริ่มงานและสถานที่ทำงาน"
        case (.thai, .clauseFourTitle): return "4. ค่าจ้างและเวลาทำงาน"
        case (.thai, .clauseFiveTitle): return "5. ทดลองงานและการเลิกจ้าง"
        case (.thai, .clauseSixTitle): return "6. การรักษาความลับ"
        case (.thai, .bodyPartiesPrefix): return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle): return "และ"
        case (.thai, .bodyPositionPrefix): return "ลูกจ้างเข้าทำงานในตำแหน่ง"
        case (.thai, .bodyDutiesPrefix): return "หน้าที่งานประกอบด้วย"
        case (.thai, .bodyStartPrefix): return "การจ้างงานเริ่มต้น"
        case (.thai, .bodyWorkplacePrefix): return "สถานที่ทำงานคือ"
        case (.thai, .bodySalaryPrefix): return "เงินเดือนหรือค่าตอบแทนกำหนดไว้ที่"
        case (.thai, .bodyHoursPrefix): return "เวลาทำงานหรือขอบเขตงานคือ"
        case (.thai, .bodyProbationPrefix): return "เงื่อนไขเกี่ยวกับการทดลองงานมีดังนี้"
        case (.thai, .bodyTerminationPrefix): return "เงื่อนไขเกี่ยวกับการเลิกจ้างมีดังนี้"
        case (.thai, .bodyConfidentialityPrefix): return "เงื่อนไขเกี่ยวกับการรักษาความลับมีดังนี้"
        case (.thai, .bodyGoodFaith): return "คู่สัญญายืนยันว่าได้อ่าน เข้าใจ และทำสัญญาจ้างงานนี้โดยสมัครใจ"
        case (.thai, .defaultDuties): return "นายจ้างจะกำหนดหน้าที่งานเพิ่มเติมภายในขอบเขตของตำแหน่ง"
        case (.thai, .defaultHours): return "เวลาทำงานจะกำหนดโดยตารางงานหรือข้อตกลงเพิ่มเติมระหว่างคู่สัญญา"
        case (.thai, .defaultProbation): return "สัญญานี้ไม่ได้ระบุระยะทดลองงานไว้เป็นพิเศษ"
        case (.thai, .defaultTermination): return "การเลิกจ้างจะเป็นไปตามกฎหมายและหนังสือบอกกล่าวระหว่างคู่สัญญา"
        case (.thai, .defaultConfidentiality): return "ลูกจ้างต้องดูแลข้อมูลภายในอย่างเหมาะสมและไม่เปิดเผยข้อมูลโดยไม่มีอำนาจ"
        }
    }
}

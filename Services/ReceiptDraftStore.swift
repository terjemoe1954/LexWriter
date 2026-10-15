//
//  ReceiptDraftStore.swift
//  LexWriter
//

import Foundation

struct ReceiptDraftStore {
    static let storageKey = "receiptDraft.v1"

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func load() -> ReceiptFormData? {
        guard
            let data = userDefaults.data(forKey: Self.storageKey),
            let draft = try? JSONDecoder().decode(ReceiptDraft.self, from: data)
        else {
            return nil
        }
        return draft.formData
    }

    func save(_ formData: ReceiptFormData) {
        guard formData.hasDraftContent else {
            clear()
            return
        }
        guard let data = try? JSONEncoder().encode(ReceiptDraft(formData: formData)) else { return }
        userDefaults.set(data, forKey: Self.storageKey)
    }

    func clear() {
        userDefaults.removeObject(forKey: Self.storageKey)
    }
}

private struct ReceiptDraft: Codable {
    let issuer: PartyDraft
    let payer: PartyDraft
    let receiptFor: String
    let amount: String
    let paymentDateText: String
    let paymentMethod: String
    let notes: String
    let signingPlace: String
    let signingDate: Date

    init(formData: ReceiptFormData) {
        issuer = PartyDraft(party: formData.issuer)
        payer = PartyDraft(party: formData.payer)
        receiptFor = formData.receiptFor
        amount = formData.amount
        paymentDateText = formData.paymentDateText
        paymentMethod = formData.paymentMethod
        notes = formData.notes
        signingPlace = formData.signingPlace
        signingDate = formData.signingDate
    }

    var formData: ReceiptFormData {
        ReceiptFormData(
            issuer: issuer.party,
            payer: payer.party,
            receiptFor: receiptFor,
            amount: amount,
            paymentDateText: paymentDateText,
            paymentMethod: paymentMethod,
            notes: notes,
            signingPlace: signingPlace,
            signingDate: signingDate
        )
    }
}

private struct PartyDraft: Codable {
    let name: String
    let address: String
    let phone: String
    let email: String

    init(party: ContractParty) {
        name = party.name
        address = party.address
        phone = party.phone
        email = party.email
    }

    var party: ContractParty {
        ContractParty(name: name, address: address, phone: phone, email: email)
    }
}

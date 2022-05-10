//
//  VerificationModel.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation

class VerificationModel {

    private let mailsArray = ["@gmail.com", "@yandex.ru", "@yahoo.com"]

    public var nameMail = String()
    public var filteredMailArray = [String]()

    private func filteringMails(text: String) {
        var domainMail = String()
        filteredMailArray = []

        guard let firstIndex = text.firstIndex(of: "@") else { return }
        guard let endIndex = text.elementIndex(before: text.endIndex) else { return }
        let range = text[firstIndex...endIndex]
        domainMail = String(range)

        mailsArray.forEach { mail in
            if mail.contains(domainMail) {
                if !filteredMailArray.contains(mail) {
                    filteredMailArray.append(mail)
                }
            }
        }
    }

    private func deriveNameMail(text: String) {
        guard let atSymbolIndex = text.firstIndex(of: "@") else { return }
        guard let endIndex = text.elementIndex(before: atSymbolIndex) else { return }

        let firstIndex = text.startIndex
        let range = text[firstIndex...endIndex]
        nameMail = String(range)
    }

    public func getFilteredMail(text: String) {
        filteringMails(text: text)
    }

    public func getMailName(text: String) {
        deriveNameMail(text: text)
    }

}

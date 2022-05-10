//
//  MailResponseModel.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation

struct MailResponseModel: Decodable {

    let result: String
    let reason: String
    let didYouMean: String?
    let success: Bool

    var reasonDescription: String {
        switch reason {
        case "invalid_email":
            return "Specified email is not a valid email address syntax"
        case "invalid_domain":
            return "Domain for email does not exist"
        case "rejected_email":
            return "Email address was rejected by the SMTP server, email address does not exist"
        case "accepted_email":
            return "Email address was accepted by the SMTP server"
        case "low_quality":
            return "Email address has quality issues that may make it a risky or low-value address"
        case "low_deliverability":
            return "Email address appears to be deliverable, but deliverability cannot be guaranteed"
        case "no_connect":
            return "Could not connect to SMTP server"
        case "timeout":
            return "SMTP session timed out"
        case "invalid_smtp":
            return "SMTP server returned an unexpected/invalid response"
        case "unavailable_smtp":
            return "SMTP server was unavailable to process our request"
        case "unexpected_error":
            return "An unexpected error has occurred"
        default: return "No Data"
        }
    }

}

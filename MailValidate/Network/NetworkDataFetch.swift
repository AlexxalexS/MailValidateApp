//
//  NetworkDataFetch.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation

class NetworkDataFetch {

    static let shared = NetworkDataFetch()
    private init() {}

    func fetchMail(verifiableMail: String, response: @escaping(MailResponseModel?, Error?) -> Void) {
        NetworkRequest.shared.requestDate(verifiableMail: verifiableMail) { result in
            switch result {
            case .success(let data):
                do {
                    let mail = try JSONDecoder().decode(MailResponseModel.self, from: data)
                    response(mail, nil)
                } catch let jsonError {
                    print("Failed decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received request data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }

}

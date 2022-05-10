//
//  NetworkRequest.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation

final class NetworkRequest {

    static let shared = NetworkRequest()
    private init() {}

    final func requestDate(verifiableMail: String, completion: @escaping(Result<Data, Error>) -> Void) {
        let urlString = "https://api.kickbox.com/v2/verify?email=\(verifiableMail)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }

                guard let data = data else {
                    return
                }
                completion(.success(data))

            }
        }.resume()
    }

}

//
//  LoginService.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation

final class LoginService {

    func login(email: String, password: String, onSuccess: (() -> Void)?, onError: (() -> Void)?) {
        let url = URL(string: "http://demo6.alpha.vkhackathon.com:8844/auth")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try! JSONSerialization.data(
            withJSONObject: parameters,
            options: .prettyPrinted
        )

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil,
                    (200 ... 299) ~= response.statusCode,
                    let responseData = try? JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                    ) as? [String: Any],
                    let token = responseData["token"] as? String
                else {
                    onError?()
                    return
                }
                UserDefaults.standard.token = token
                onSuccess?()
            }
        }

        task.resume()
    }

}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

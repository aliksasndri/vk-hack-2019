//
//  SpeechRecognitionService.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Speech

final class SpeechRecognitionService {

    // MARK: - Constants

    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))

    // MARK: - Properties

    var isAvailable: Bool {
        return recognizer?.isAvailable ?? false
    }

    // MARK: - Internal helpers

    @discardableResult
    func requestAuth() -> Bool {
        var isAuth = false
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                print("authorized")
                isAuth = true
            case .denied:
                print("denied")
                isAuth = false
            case .restricted:
                print("restricted")
                isAuth = false
            case .notDetermined:
                print("notDetermined")
                isAuth = false
            @unknown default:
                print("SWIFT 5")
                isAuth = false
            }
        }

        return isAuth
    }

    func recognize(url: URL, success: @escaping (String) -> Void) {
        guard
            let recognizer = recognizer
        else {
            print("recognizer is nil")
            return
        }

        let request = SFSpeechURLRecognitionRequest(url: url)

        recognizer.recognitionTask(with: request) { result, error in
            guard
                let result = result
            else {
                print(error ?? "unknown recognition error")
                return
            }

            if result.isFinal {
                success(result.bestTranscription.formattedString)
            }
        }
    }
}

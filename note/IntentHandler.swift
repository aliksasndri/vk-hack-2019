//
//  IntentHandler.swift
//  note
//
//  Created by Anton Dryakhlykh on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is INCreateNoteIntent {
            return NoteHandler()
        }
        return self
    }
    
}

class NoteHandler: NSObject, INCreateNoteIntentHandling {
    func handle(intent: INCreateNoteIntent, completion: @escaping (INCreateNoteIntentResponse) -> Void) {

        completion(INCreateNoteIntentResponse(code: .success, userActivity: .none))
    }

    func confirm(intent: INCreateNoteIntent, completion: @escaping (INCreateNoteIntentResponse) -> Swift.Void) {
        completion(INCreateNoteIntentResponse(code: INCreateNoteIntentResponseCode.ready, userActivity: nil))
    }

    func resolveTitle(forCreateNote intent: INCreateNoteIntent, with completion: @escaping (INStringResolutionResult) -> Swift.Void) {
        let result: INStringResolutionResult
        if let title = intent.title?.spokenPhrase, title.count > 0 {
            result = INStringResolutionResult.success(with: title)
        } else {
            result = INStringResolutionResult.needsValue()
        }
        completion(result)
    }

    func resolveContent(for intent: INCreateNoteIntent, with completion: @escaping (INNoteContentResolutionResult) -> Swift.Void) {
        let result: INNoteContentResolutionResult
        if let content = intent.content {
            result = INNoteContentResolutionResult.success(with: content)
        } else {
            result = INNoteContentResolutionResult.notRequired()
        }
        completion(result)
    }
}

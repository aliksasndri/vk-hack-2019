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
        return self
    }
    
}

class NoteHandler: NSObject, INCreateNoteIntentHandling {
    func handle(intent: INCreateNoteIntent, completion: @escaping (INCreateNoteIntentResponse) -> Void) {
        completion(INCreateNoteIntentResponse(code: .inProgress, userActivity: .none))
    }
}

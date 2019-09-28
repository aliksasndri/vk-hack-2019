//
//  AudioRecorderDelegate.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation

protocol AudioRecorderDelegate: class {
    func audioRecorder(_ audioRecorder: AudioRecorder, userDidGrantPermissionOnRecord: Bool)
    func audioRecorder(_ audioRecorder: AudioRecorder, didFinishRecordingWithError: Error)
    func audioRecorder(_ audioRecorder: AudioRecorder, cantStartSessionWithError: Error)
    func audioRecorderDidFinishRecording(_ audioRecorder: AudioRecorder)
}

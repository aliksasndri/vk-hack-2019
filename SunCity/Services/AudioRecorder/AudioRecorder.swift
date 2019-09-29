//
//  AudioRecorder.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import AVFoundation

final class AudioRecorder: NSObject {

    // MARK: - Properties

    weak var delegate: AudioRecorderDelegate?

    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer: AVAudioPlayer!
    private let session = AVAudioSession.sharedInstance()

    // MARK: - Internal methods

    func setup() {
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            try session.overrideOutputAudioPort(.speaker)
            session.requestRecordPermission() { [weak self] allowed in
                guard let self = self else { return }
                self.delegate?.audioRecorder(self, userDidGrantPermissionOnRecord: allowed)
            }
        } catch {
            delegate?.audioRecorder(self, cantStartSessionWithError: error)
        }
    }

    func startRecording(filename: String) {
        let audioFilename = filePath(filename: filename)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(error: error)
        }
    }

    func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
    }

    func play(filename: String) {
        if audioPlayer == nil {
            preparePlay(filename: filename)
        }

        if audioRecorder != nil, audioRecorder.isRecording {
            finishRecording()
        }

        if audioPlayer.isPlaying {
            pause()
        } else {
            let audioFilename = filePath(filename: filename).path
            if FileManager.default.fileExists(atPath: audioFilename) {
                preparePlay(filename: filename)
                audioPlayer.play()
            } else {
                // TODO: Throw error
            }
        }
    }

    func pause() {
        guard audioPlayer != nil else {
            return
        }

        if audioRecorder != nil, audioRecorder.isRecording {
            finishRecording()
        }

        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }

    // MARK: - Private methods

    private func preparePlay(filename: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePath(filename: filename))
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        } catch {
            // TODO: throw error
            debugPrint(error)
        }
    }

    private func finishRecording(error: Error?) {
        finishRecording()
        if let error = error {
            delegate?.audioRecorder(self, didFinishRecordingWithError: error)
        } else {
            delegate?.audioRecorderDidFinishRecording(self)
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func filePath(filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent("\(filename).m4a")
    }

}

extension AudioRecorder: AVAudioPlayerDelegate {

}

// MARK: - AVAudioRecorderDelegate

extension AudioRecorder: AVAudioRecorderDelegate {

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully: Bool) {
        if !successfully {
            finishRecording(error: AudioRecorderError.disturbedBySystem)
        }
    }

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        finishRecording(error: error)
    }

}

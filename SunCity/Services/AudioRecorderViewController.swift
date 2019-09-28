//
//  AudioRecorderViewController.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

/// Shows example usage of AudioRecorder
final class AudioRecorderViewController: UIViewController {

    let recorder = AudioRecorder()
    let startButton = UIButton(type: .system)
    let stopButton = UIButton(type: .system)
    let playButton = UIButton(type: .system)

    let filename = "myrecord"

    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)

        stopButton.setTitle("Stop", for: .normal)
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        stopButton.isEnabled = false

        playButton.setTitle("Play", for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)

        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(playButton)

        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])

        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: startButton.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            stopButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])

        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: stopButton.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])

        recorder.setup()
    }


    @objc
    func start() {
        recorder.startRecording(filename: filename)
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }

    @objc
    func stop() {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        recorder.finishRecording()
    }

    @objc
    func play() {
        recorder.play(filename: filename)
    }

}

// MARK: - AudioRecorderDelegate

extension AudioRecorderViewController: AudioRecorderDelegate {

    func audioRecorder(_ audioRecorder: AudioRecorder, userDidGrantPermissionOnRecord: Bool) {
        print(#function)
    }

    func audioRecorder(_ audioRecorder: AudioRecorder, didFinishRecordingWithError: Error) {
        print(#function)
    }

    func audioRecorder(_ audioRecorder: AudioRecorder, cantStartSessionWithError: Error) {
        print(#function)
    }

    func audioRecorderDidFinishRecording(_ audioRecorder: AudioRecorder) {
        print(#function)
    }

}

//
//  ExpandableView.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import YXWaveView

final class FeedbackAudioView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!

    // MARK: - IBActions

    @IBAction func mainButtonAction(_ sender: Any) {
        configure(for: state.toggle)
        didTap?()
    }

    // MARK: - Enums

    enum State {
        case ready
        case recording
        case ended

        var toggle: State {
            switch self {
            case .ready:
                return .recording
            case .recording:
                return .ended
            case .ended:
                return .ended
            }
        }
    }

    // MARK: - Constants

    private let waterView = YXWaveView(frame: .zero, color: UIColor(red: 1, green: 0.8, blue: 0.22, alpha: 1))

    // MARK: - Properties

    var didTap: (() -> Void)?
    private var state: State = .ready
    private var counter = 0.0
    private var timer = Timer()
    private var isPlaying = false

    // MARK: - Initialization and deinitialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
        configureAppearance()
    }

    deinit {
        timer.invalidate()
    }

    // MARK: - UIKit

    override func layoutSubviews() {
        super.layoutSubviews()
        addCardShadow()
        containerView.roundAllCorners(radius: 56.0)
        addWave()
    }

    // MARK: - Internal helpers

    func configure(for state: State) {
        self.state = state

        switch state {
        case .ready:
            waterView._stop()
            arrowImageView.image = UIImage(named: "mic")
            containerView.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.22, alpha: 1)
            timer.invalidate()
            counter = 0.0
            nameLabel.text = "Записать аудио"
        case .recording:
            waterView.start()
            arrowImageView.image = UIImage(named: "stop")
            containerView.backgroundColor = .white

            if isPlaying {
                return
            }

            nameLabel.text = String(counter)

            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
                self?.counter += 0.1
                self?.nameLabel.text = String(format: "%.1f", self?.counter ?? "")
            })
        case .ended:
            waterView.stop()
            arrowImageView.image = UIImage(named: "play")
            containerView.backgroundColor = .white
            timer.invalidate()
            isPlaying = false
        }
    }

    func set(color: UIColor, textColor: UIColor, title: String, image: UIImage?) {
        topView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        containerView.backgroundColor = color
        nameLabel.text = title
        nameLabel.textColor = textColor
        arrowImageView.image = image
    }
}

private extension FeedbackAudioView {
    func configureAppearance() {
        backgroundColor =  UIColor.white.withAlphaComponent(0.0)
        containerView.backgroundColor = .white
    }

    func addWave() {
        waterView.translatesAutoresizingMaskIntoConstraints = false
        waterView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        containerView.insertSubview(waterView, at: 0)
        waterView.waveHeight = containerView.frame.height / 4.0

        NSLayoutConstraint.activate([
            waterView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            waterView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            waterView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}

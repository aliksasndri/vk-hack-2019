//
//  ExpandableView.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

final class FeedbackExpandableView: UIView {

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
        case expanded
        case collapsed

        var toggle: State {
            switch self {
            case .expanded:
                return .collapsed
            case .collapsed:
                return .expanded
            }
        }
    }

    // MARK: - Properties

    var didTap: (() -> Void)?
    private var state: State = .collapsed
    private var textView = UITextView()
    private var cornerRadius: CGFloat = 56.0

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

    // MARK: - UIKit

    override func layoutSubviews() {
        super.layoutSubviews()
        addCardShadow()
        containerView.roundAllCorners(radius: cornerRadius)
    }

    // MARK: - Internal helpers

    func configure(for state: State) {
        self.state = state

        switch state {
        case .collapsed:
            textView.isHidden = true
            topView.isHidden = false
            containerView.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.22, alpha: 1)
            textView.resignFirstResponder()
            cornerRadius = 56.0
            textView.text = ""
        case .expanded:
            containerView.backgroundColor = .white
            topView.isHidden = true
            textView.isHidden = false
            textView.becomeFirstResponder()
            cornerRadius = 18.0
        }

        layoutSubviews()
    }

    func set(color: UIColor, textColor: UIColor, title: String, image: UIImage?) {
        topView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        containerView.backgroundColor = color
        nameLabel.text = title
        nameLabel.textColor = textColor
        arrowImageView.image = image
    }

    func fill(textView: UITextView) {
        self.textView = textView
        textView.isHidden = true
        stackView.addArrangedSubview(textView)
    }
}

private extension FeedbackExpandableView {
    func configureAppearance() {
        backgroundColor =  UIColor.white.withAlphaComponent(0.0)
        containerView.backgroundColor = .white
    }
}

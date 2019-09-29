//
//  ExpandableView.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

final class ExpandableView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!

    // MARK: - IBActions
    
    @IBAction func mainButtonAction(_ sender: Any) {
        configure(for: state.toggle)
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

    private var state: State = .collapsed
    private var fields: [TextField] = []

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
        containerView.roundAllCorners(radius: 18.0)
    }

    // MARK: - Internal helpers

    func configure(for state: State) {
        self.state = state

        switch state {
        case .collapsed:
            arrowImageView.image = UIImage(named: "arrowDown")
            fields.forEach { $0.isHidden = true }
        case .expanded:
            arrowImageView.image = UIImage(named: "arrowUp")
            fields.forEach { $0.isHidden = false }
        }
    }

    func fill(title: String, textFields: [TextField]) {
        self.nameLabel.text = title
        self.fields = textFields

        textFields.forEach { [weak self] textField in
            self?.stackView.addArrangedSubview(textField)
        }

        configure(for: .collapsed)
    }
}

private extension ExpandableView {
    func configureAppearance() {
        backgroundColor =  UIColor.white.withAlphaComponent(0.0)
        containerView.backgroundColor = .white
        percentView.layer.cornerRadius = 8.0
        percentView.clipsToBounds = true
        percentLabel.text = "0%"
    }
}

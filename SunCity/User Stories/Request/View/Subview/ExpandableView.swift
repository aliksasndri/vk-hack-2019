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
            stackView.arrangedSubviews.forEach { [weak self] view in
                guard self?.topView != view else { return }
                view.removeFromSuperview()
            }
        case .expanded:
            arrowImageView.image = UIImage(named: "arrowUp")
            for _ in 0...4 {
                let textField = TextField()
                textField.placeholder = "Имя"
                textField.title = "Не имя"
                stackView.addArrangedSubview(textField)
            }
        }
    }

    func fill() {
        nameLabel.text = "Общие сведения"
        percentLabel.text = "13%"
    }
}

private extension ExpandableView {
    func configureAppearance() {
        backgroundColor =  UIColor.white.withAlphaComponent(0.0)
        containerView.backgroundColor = .white
        percentView.cornerRadius = 8.0
        percentView.clipsToBounds = true
    }
}

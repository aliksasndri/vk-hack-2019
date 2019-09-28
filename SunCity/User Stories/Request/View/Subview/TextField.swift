//
//  TextField.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import SkyFloatingLabelTextField

final class TextField: SkyFloatingLabelTextField {

    // MARK: - Initialization and deinitialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureAppearance()
    }

    // MARK: - SkyFloatingLabelTextField

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(x: 16.0, y: 19.0, width: superRect.width - 32.0, height: superRect.size.height - 20.0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(x: 16.0, y: 19.0, width: superRect.width - 32.0, height: superRect.size.height - 20.0)
    }

    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        return CGRect(x: 16.0, y: 10.0, width: bounds.size.width - 32.0, height: titleHeight() - 4.0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(x: 16.0, y: 19.0, width: superRect.width - 32.0, height: superRect.size.height - 20.0)
    }

    // MARK: - Internal helpers

    func fill(placeholder: String) {
        self.placeholder = placeholder
        self.title = placeholder
    }

}

// MARK: - Private helpers

private extension TextField {
    func configureAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 56.0).isActive = true

        lineView.isHidden = true
        layer.cornerRadius = 12.0

        backgroundColor = UIColor(red: 0.49, green: 0.64, blue: 0.27, alpha: 0.1)
        tintColor = UIColor(red: 0.34, green: 0.59, blue: 0.18, alpha: 1)
        textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        selectedTitleColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        titleFont = UIFont.systemFont(ofSize: 10.0)
        font = UIFont.systemFont(ofSize: 16.0)
        placeholderFont = UIFont.systemFont(ofSize: 16.0)
        titleFormatter = { $0 }
    }
}

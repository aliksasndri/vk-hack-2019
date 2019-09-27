//
//  UIView.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

// MARK: - Xib

import UIKit

extension UIView {

    /// Helper method to init and setup the view from the Nib.
    func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)
    }

    /// Method to init the view from a Nib.
    ///
    /// - Returns: Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            return T()
        }

        return view
    }

    static func loadFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            return T()
        }

        return view
    }

    /// Stretches the input view to the UIView frame using Auto-layout
    ///
    /// - Parameter view: The view to stretch.
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension UIView {
    func round(corners: UIRectCorner, with radius: CGFloat) {
        let cornerRadii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func roundAllCorners(radius: CGFloat) {
        round(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], with: radius)
    }

    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set(value) {
            layer.cornerRadius = value
        }
    }
}

extension UIView {
    func addCardShadow() {
        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.shadowColor = UIColor(red: 0.33, green: 0.34, blue: 0.34, alpha: 0.05).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 30.0
        layer.shadowOffset = CGSize(width: 0.0,
                                    height: 8.0)
    }
}

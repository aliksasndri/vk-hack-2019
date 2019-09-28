//
//  ActivityViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class ActivityViewController: UIViewController, ActivityModuleOutput {

    // MARK: - Subviews

    @IBOutlet private weak var titleContainer: UIView!
    @IBOutlet private weak var subtitleContainer: UIView!

    // MARK: - Properties

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.93, alpha: 1)
        titleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        titleContainer.cornerRadius = 24
        subtitleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        subtitleContainer.cornerRadius = 24
    }

    // MARK: - Internal helpers

}

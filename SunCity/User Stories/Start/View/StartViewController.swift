//
//  StartViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController, StartModuleOutput {

    // MARK: - Subviews

    @IBOutlet weak var fillFormButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!

    // MARK: - Properties

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Internal helpers

    // MARK: - Actions

    @IBAction private func fill(_ sender: Any) {
    }

    @IBAction private func login(_ sender: Any) {
        let (viewController, _) = LoginModuleConfigurator().configure()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

}

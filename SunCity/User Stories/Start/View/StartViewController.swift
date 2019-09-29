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
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Internal helpers

    // MARK: - Actions

    @IBAction private func fill(_ sender: Any) {
        let (controller, _) = RequestModuleConfigurator().configure()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }

    @IBAction private func login(_ sender: Any) {
        let (viewController, _) = LoginModuleConfigurator().configure()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

}

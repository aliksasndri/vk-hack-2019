//
//  LoginViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, LoginModuleOutput {

    @IBOutlet weak var enterButtonBottomConstraint: NSLayoutConstraint!
    // MARK: - Properties

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Internal helpers

    // MARK: - Actions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

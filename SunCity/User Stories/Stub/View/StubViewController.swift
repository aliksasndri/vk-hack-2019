//
//  StubViewController.swift
//  SunCity
//
//  Created by Alexander Kravchenkov on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class StubViewController: UIViewController, StubModuleOutput {

    // MARK: - StubModuleOutput

    // MARK: - Properties

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Internal helpers

}

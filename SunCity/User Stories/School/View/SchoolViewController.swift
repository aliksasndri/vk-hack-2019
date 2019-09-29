//
//  SchoolViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class SchoolViewController: UIViewController, SchoolModuleOutput {
    @IBAction func pass(_ sender: Any) {
        let vc = StubModuleConfigurator().configure().0
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - SchoolModuleOutput

    // MARK: - Properties

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Internal helpers

}

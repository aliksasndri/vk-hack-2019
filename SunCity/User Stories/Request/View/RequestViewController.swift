//
//  RequestViewController.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class RequestViewController: UIViewController, RequestModuleOutput {

    // MARK: - IBOutlets

    @IBOutlet weak var stackView: UIStackView!

    // MARK: - RequestModuleOutput

    // MARK: - Properties

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addDropdowns()
    }

    // MARK: - Internal helpers

}

// MARK: - Private helpers

private extension RequestViewController {
    func addDropdowns() {
        let userInfo = ExpandableView()
        
    }
}

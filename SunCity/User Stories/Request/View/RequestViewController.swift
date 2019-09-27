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

        for _ in 0...0 {
            let view = ExpandableView()
            view.fill()
            stackView.addArrangedSubview(view)
        }
    }

    // MARK: - Internal helpers

}

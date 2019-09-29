//
//  PostDetailsViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class PostDetailsViewController: UIViewController, PostDetailsModuleOutput {

    // MARK: - Properties

    @IBOutlet weak var toRoundView: UIView!
    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toRoundView.layer.cornerRadius = 30
        toRoundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Internal helpers

}

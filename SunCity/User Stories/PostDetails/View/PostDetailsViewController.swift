//
//  PostDetailsViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class PostDetailsViewController: UIViewController, PostDetailsModuleOutput {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var audioContainer: UIView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var picContainer: UIView!
    @IBOutlet weak var mainStack: UIStackView!
    
    // MARK: - Properties

    @IBOutlet weak var toRoundView: UIView!
    var feedback: Feedback!

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toRoundView.layer.cornerRadius = 30
        toRoundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textLabel.text = feedback.text
        dateLabel.text = feedback.date.toWeekDayAndDateString()
        if feedback.images.count > 0 {
            picture.loadImage(
                with: "http://demo6.alpha.vkhackathon.com:8844" + feedback.images.first!,
                placeholderImage: UIImage.imageWithColor(
                    UIColor(red: 0.85, green: 0.88, blue: 0.8, alpha: 1)
                )
            )
        } else {
            picContainer.isHidden = true
        }
        audioContainer.isHidden = feedback.audio == ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

        for item in self.feedback.comments ?? [] {

            let custom = CommentView()
            custom.configure(comment: item)
            self.mainStack.addArrangedSubview(custom)
        }
    }

    // MARK: - Internal helpers

}

extension UIImage {

/// Creates image with given UIColor. Commonly used for setting UIButton background.
    class func imageWithColor(_ color: UIColor, of size: CGSize = CGSize(width: 1.0, height: 1.0)) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        // need to disable warning here, cause in other way we can't get nonoptional output,
        // and here we guarantee nonnil value.
        // swiftlint:disable force_unwrapping
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // swiftlint:enable force_unwrapping
        UIGraphicsEndImageContext()
        return image
    }

}

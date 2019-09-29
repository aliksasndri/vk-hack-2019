//
//  MessageView.swift
//  SunCity
//
//  Created by Александр Кравченков on 29/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit
import Nuke

public class CommentView: UIView {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }


    func configure(comment: Comment) {
        photo.loadImage(with: "http://demo6.alpha.vkhackathon.com:8844" + comment.image,
                        placeholderImage: UIImage(named: "avatar_placeholder"),
                        fadeInDuration: 0.1)

        name.text = comment.name
        message.text = comment.text
    }
}

//
//  DiaryRecordCell.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

final class DiaryRecordCell: UITableViewCell {

    @IBOutlet weak var contentContainerView: UIView!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!

    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentsContainer: UIView!

    @IBOutlet weak var photosCountLabel: UILabel!
    @IBOutlet weak var photosContainer: UIView!

    @IBOutlet weak var audioContainer: UIView!
    @IBOutlet weak var minutesAudioLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(minutesAudio: String?, commentsCount: String?, photosCount: String?, text: String, date: String) {
        minutesAudioLabel.text = minutesAudio ?? "0"
        commentsCountLabel.text = commentsCount ?? "0"
        photosCountLabel.text = photosCount ?? "0"
        textContentLabel.text = text
        dateLabel.text = date
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        set(highlighted: highlighted,
            containerView: contentContainerView,
            highlightedColor: UIColor.white.withAlphaComponent(0.3),
            baseColor: .white)
    }
    
}

extension UITableViewCell {

    func set(highlighted: Bool,
             highlightedColor: UIColor,
             baseColor: UIColor) {

        set(highlighted: highlighted,
            containerView: contentView,
            highlightedColor: highlightedColor,
            baseColor: baseColor)
    }

    func set(highlighted: Bool,
             containerView: UIView,
             highlightedColor: UIColor,
             baseColor: UIColor) {

        let color = highlighted ? highlightedColor : baseColor

        UIView.animate(withDuration: 0.33) {
            containerView.backgroundColor = color
        }
    }
}

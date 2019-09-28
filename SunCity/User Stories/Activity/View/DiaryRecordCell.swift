//
//  DiaryRecordCell.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

final class DiaryRecordCell: UITableViewCell {

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
    }

    func configure(minutesAudio: String?, commentsCount: String?, photosCount: String?, text: String, date: String) {
        minutesAudioLabel.text = minutesAudio
        commentsCountLabel.text = commentsCount
        photosCountLabel.text = photosCount
        textContentLabel.text = text
        dateLabel.text = date
        photosContainer.isHidden = photosCount == nil
        audioContainer.isHidden = minutesAudio == nil
    }
    
}

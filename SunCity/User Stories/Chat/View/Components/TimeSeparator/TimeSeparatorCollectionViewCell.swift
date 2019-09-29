//
//  TimeSeparatorCollectionViewCell.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit
import Chatto

class TimeSeparatorCollectionViewCell: UICollectionViewCell {

    // MARK: - Subviews

    private let label: UILabel = UILabel()

    // MARK: - Properties

    var text: String = "" {
        didSet {
            if oldValue != text {
                self.setTextOnLabel(text)
            }
        }
    }

    // MARK: - Initialization and deinitialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.bounds.size = self.label.sizeThatFits(self.contentView.bounds.size)
        self.label.center = self.contentView.center
    }

    // MARK: - Private methods

    private func setTextOnLabel(_ text: String) {
        self.label.text = text
        self.setNeedsLayout()
    }

    private func commonInit() {
        self.label.font = UIFont.systemFont(ofSize: 12)
        self.label.textAlignment = .center
        self.label.textColor = UIColor.gray
        self.contentView.addSubview(label)
    }

}

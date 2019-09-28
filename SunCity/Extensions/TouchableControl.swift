//
//  TouchableControl.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

public class TouchableControl: UIButton {

    // MARK: - Constants

    private enum Constants {
        static let touchAlphaValue: CGFloat = 0.3
        static let normalAlhpaValue: CGFloat = 1
        static let duration: TimeInterval = 0.2
    }

    // MARK: - Public Properties

    var animatingViews: [UIView]?

    // MARK: - Private Properties

    private var animating = false
    private var shouldAnimateBack = false

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        addActions()
    }

    private func addActions() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpinside), for: .touchUpInside)

        addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
    }

    @objc
    private func touchCancel() {
        animateBack()
    }

    @objc
    private func touchDragExit() {
        animateBack()
    }

    @objc
    private func touchDown() {
        animateDown()
    }

    @objc
    private func touchUpinside() {
        animateBack()
    }

    private func animateDown() {
        guard !animating else { return }

        animating = true
        UIView.animate(withDuration: Constants.duration,
                       animations: {
                        self.alpha = Constants.touchAlphaValue
                        self.animatingViews?.forEach({ (view) in
                            view.alpha = Constants.touchAlphaValue
                        })
        }) { (_ ) in
            self.animating = false
            if self.shouldAnimateBack {
                self.animateBack()
            }
        }
    }

    private func animateBack() {
        guard !animating else {
            shouldAnimateBack = true
            return
        }
        animating = true
        UIView.animate(withDuration: Constants.duration,
                       animations: {
                        self.alpha = Constants.normalAlhpaValue
                        self.animatingViews?.forEach({ (view) in
                            view.alpha = Constants.normalAlhpaValue
                        })
        }) { (_ ) in
            self.animating = false
            self.shouldAnimateBack = false
        }
    }
}

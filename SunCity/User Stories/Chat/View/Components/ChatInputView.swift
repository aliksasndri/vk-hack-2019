//
//  ChatInputView.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

final class ChatInputView: UIView {

    // MARK: - Subviews

    private let textView = ExpandableTextView()
    private let sendButton = UIButton(type: .custom)

    public var maxCharactersCount: UInt? // nil -> unlimited
    
    // MARK: - Properties

    var onSend: ((String) -> Void)?

    var inputText: String {
        get {
            return self.textView.text
        }
        set {
            self.textView.text = newValue
            self.updateSendButton()
        }
    }

    var inputSelectedRange: NSRange {
        get {
            return self.textView.selectedRange
        }
        set {
            self.textView.selectedRange = newValue
        }
    }

    private var placeholderText: String {
        get {
            return self.textView.placeholderText
        }
        set {
            self.textView.placeholderText = newValue
        }
    }
    private var shouldEnableSendButton = { (inputView: ChatInputView) -> Bool in
        return !inputView.textView.text.isEmpty
    }

    // MARK: - Initialization and deinitialization

    init() {
        super.init(frame: .zero)
        textView.scrollsToTop = false
        textView.delegate = self
        sendButton.isEnabled = false
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6),
            sendButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            sendButton.widthAnchor.constraint(equalToConstant: 36),
            sendButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        sendButton.setImage(UIImage(named: "button_send"), for: .normal)
        sendButton.setImage(UIImage(named: "button_send_inactive"), for: .disabled)
        sendButton.setImage(UIImage(named: "button_send_inactive"), for: .highlighted)

        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: sendButton.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])

        bringSubviewToFront(sendButton)

        let topBorder = UIView()
        if #available(iOS 13, *) {
            topBorder.backgroundColor = .separator
        } else {
            topBorder.backgroundColor = .lightGray
        }
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topBorder)
        NSLayoutConstraint.activate([
            topBorder.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            topBorder.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            topBorder.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            topBorder.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])

        textView.backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView

    override func layoutSubviews() {
        self.updateConstraints() // Interface rotation or size class changes will reset constraints as defined in interface builder -> constraintsForVisibleTextView will be activated
        super.layoutSubviews()
    }

    // MARK: - Actions

    @objc
    private func sendAction() {
        onSend?(inputText)
        textView.text = nil
    }

    // MARK: - Private methods

    private func updateSendButton() {
        self.sendButton.isEnabled = self.shouldEnableSendButton(self)
    }

    private func updateIntrinsicContentSizeAnimated() {
       let options: UIView.AnimationOptions = [.beginFromCurrentState, .allowUserInteraction]
       UIView.animate(withDuration: 0.25, delay: 0, options: options, animations: { () -> Void in
           self.invalidateIntrinsicContentSize()
           self.layoutIfNeeded()
       }, completion: nil)
   }

}

// MARK: - ChatInputBarAppearance

extension ChatInputView {

    func setAppearance(_ appearance: ChatInputBarAppearance) {
        textView.font = appearance.textInputAppearance.font
        textView.textColor = appearance.textInputAppearance.textColor
        textView.tintColor = appearance.textInputAppearance.tintColor
        textView.textContainerInset = appearance.textInputAppearance.textInsets
        textView.setTextPlaceholderFont(appearance.textInputAppearance.placeholderFont)
        textView.setTextPlaceholderColor(appearance.textInputAppearance.placeholderColor)
        textView.placeholderText = appearance.textInputAppearance.placeholderText
        textView.layer.borderColor = appearance.textInputAppearance.borderColor.cgColor
        textView.layer.borderWidth = appearance.textInputAppearance.borderWidth
        textView.accessibilityIdentifier = appearance.textInputAppearance.accessibilityIdentifier
    }

}

// MARK: - UITextViewDelegate

extension ChatInputView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        updateSendButton()
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn nsRange: NSRange, replacementText text: String) -> Bool {
        guard let maxCharactersCount = maxCharactersCount else { return true }
        let currentText = textView.text as NSString
        let currentCount = currentText.length
        let rangeLength = nsRange.length
        let nextCount = currentCount - rangeLength + (text as NSString).length
        return UInt(nextCount) <= maxCharactersCount
    }

}

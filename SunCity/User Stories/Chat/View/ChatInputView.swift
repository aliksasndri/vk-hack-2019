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

    public var pasteActionInterceptor: PasteActionInterceptor? {
        get { return self.textView.pasteActionInterceptor }
        set { self.textView.pasteActionInterceptor = newValue }
    }

    public var shouldEnableSendButton = { (inputView: ChatInputView) -> Bool in
        return !inputView.textView.text.isEmpty
    }

    public var inputTextView: UITextView? {
        return self.textView
    }

    var onSend: (() -> Void)?

    var textView: ExpandableTextView = ExpandableTextView()
    var sendButton: UIButton = UIButton()

    // MARK: - Initialization and deinitialization

    init() {
        super.init(frame: .zero)
        textView.scrollsToTop = false
        textView.delegate = self
        sendButton.isEnabled = false

        addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6),
            sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6),
            sendButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            sendButton.widthAnchor.constraint(equalToConstant: 36),
            sendButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        sendButton.layer.cornerRadius = 18
        sendButton.backgroundColor = .red

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
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topBorder)
        NSLayoutConstraint.activate([
            topBorder.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            topBorder.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            topBorder.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            topBorder.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])

        self.textView.backgroundColor = .lightGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var showsTextView: Bool = true {
        didSet {
            self.setNeedsUpdateConstraints()
            self.setNeedsLayout()
            self.updateIntrinsicContentSizeAnimated()
        }
    }

    var showsSendButton: Bool = true {
        didSet {
            self.setNeedsUpdateConstraints()
            self.setNeedsLayout()
            self.updateIntrinsicContentSizeAnimated()
        }
    }

    public var maxCharactersCount: UInt? // nil -> unlimited

    override func layoutSubviews() {
        self.updateConstraints() // Interface rotation or size class changes will reset constraints as defined in interface builder -> constraintsForVisibleTextView will be activated
        super.layoutSubviews()
    }

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

    var placeholderText: String {
        get {
            return self.textView.placeholderText
        }
        set {
            self.textView.placeholderText = newValue
        }
    }

    // MARK: - Actions

    @objc
    private func sendAction() {
        onSend?()
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
        self.textView.font = appearance.textInputAppearance.font
        self.textView.textColor = appearance.textInputAppearance.textColor
        self.textView.tintColor = appearance.textInputAppearance.tintColor
        self.textView.textContainerInset = appearance.textInputAppearance.textInsets
        self.textView.setTextPlaceholderFont(appearance.textInputAppearance.placeholderFont)
        self.textView.setTextPlaceholderColor(appearance.textInputAppearance.placeholderColor)
        self.textView.placeholderText = appearance.textInputAppearance.placeholderText
        self.textView.layer.borderColor = appearance.textInputAppearance.borderColor.cgColor
        self.textView.layer.borderWidth = appearance.textInputAppearance.borderWidth
        self.textView.accessibilityIdentifier = appearance.textInputAppearance.accessibilityIdentifier
        self.sendButton.contentEdgeInsets = appearance.sendButtonAppearance.insets
        self.sendButton.setTitle(appearance.sendButtonAppearance.title, for: .normal)
        appearance.sendButtonAppearance.titleColors.forEach { (state, color) in
            self.sendButton.setTitleColor(color, for: state.controlState)
        }
        self.sendButton.titleLabel?.font = appearance.sendButtonAppearance.font
        self.sendButton.accessibilityIdentifier = appearance.sendButtonAppearance.accessibilityIdentifier
    }

}

// MARK: - UITextViewDelegate

extension ChatInputView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        self.updateSendButton()
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn nsRange: NSRange, replacementText text: String) -> Bool {
        guard let maxCharactersCount = self.maxCharactersCount else { return true }
        let currentText: NSString = textView.text as NSString
        let currentCount = currentText.length
        let rangeLength = nsRange.length
        let nextCount = currentCount - rangeLength + (text as NSString).length
        return UInt(nextCount) <= maxCharactersCount
    }

}

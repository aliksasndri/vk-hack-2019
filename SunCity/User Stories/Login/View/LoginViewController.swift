//
//  LoginViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, LoginModuleOutput {

    // MARK: - Subviews

    @IBOutlet private weak var titleLabel: UILabel!
    private let emailTextField = TextField()
    private let passwordTextField = TextField()

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var enterButtonBottomConstraint: NSLayoutConstraint!

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 32),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        emailTextField.backgroundColor = .white
        emailTextField.fill(placeholder: "Ваш email")

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        passwordTextField.backgroundColor = .white
        passwordTextField.fill(placeholder: "Ваш пароль")
        passwordTextField.isSecureTextEntry = true

        addKeyboardObservers()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(gestureRecognizer)
    }

    // MARK: - Internal helpers

    // MARK: - Actions

    @objc
    private func tap() {
        view.endEditing(true)
    }

    @IBAction private func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else {
            return
        }

        let options: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: curve << 16)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [options, .beginFromCurrentState],
            animations: {
                self.enterButtonBottomConstraint.constant = self.view.frame.size.height - frame.minY - 16
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }

    @objc
    private func keyboardWillHide() {
        enterButtonBottomConstraint.constant = 16
        view.layoutIfNeeded()
    }

    // MARK: - Private methods

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

}
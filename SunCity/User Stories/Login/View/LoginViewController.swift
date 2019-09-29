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

        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
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

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.emailTextField.becomeFirstResponder()
        }
    }

    // MARK: - Actions

    @IBAction private func login(_ sender: Any) {
        view.endEditing(true)

        let service = LoginService()
        service.login(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            onSuccess: {
                guard
                    let window = UIApplication.shared.keyWindow,
                    let rootViewController = window.rootViewController
                else {
                    return
                }

                let viewController = MainTabBarConfigurator().configure()

                viewController.view.frame = rootViewController.view.frame
                viewController.view.layoutIfNeeded()

                let animation: (() -> Void) = {
                    window.rootViewController = viewController
                }

                UIView.transition(with: window,
                                  duration: 0.3,
                                  options: .transitionFlipFromRight,
                                  animations: animation)
            },
            onError: {
                let alert = UIAlertController(
                    title: "Ошибка",
                    message: "Что-то пошло не так",
                    preferredStyle: .alert
                )
                let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
        )
    }
    
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

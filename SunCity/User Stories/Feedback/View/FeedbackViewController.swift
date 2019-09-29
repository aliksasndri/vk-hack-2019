//
//  FeedbackViewController.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit
import Photos
import ImagePicker
import SurfUtils

final class FeedbackViewController: UIViewController, FeedbackModuleOutput {

    // MARK: - IBOutlets

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var storyView: FeedbackExpandableView!
    @IBOutlet weak var audioView: FeedbackAudioView!
    @IBOutlet weak var attachmentsView: FeedbackAttachView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var storyDeleteView: UIView!
    @IBOutlet weak var audioDeleteView: UIView!
    @IBOutlet weak var attachDeleteView: UIView!
    
    // MARK: - IBOutlets

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createButtonAction(_ sender: Any) {
    }
    
    @IBAction func storyDeleteButtonAction(_ sender: Any) {
        storyView.configure(for: .collapsed)
        storyDeleteView.isHidden = true
    }

    @IBAction func audioDeleteButtonAction(_ sender: Any) {
        audioView.configure(for: .ready)
        audioDeleteView.isHidden = true
    }

    @IBAction func attachDeleteButtonAction(_ sender: Any) {
        attachmentsView.configure(for: .collapsed)
        attachDeleteView.isHidden = true
    }
    
    // MARK: - FeedbackModuleOutput

    // MARK: - Properties

    private var images = [UIImage]()

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeOnKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    // MARK: - Internal helpers

}

private extension FeedbackViewController {
    func configureAppearance() {
        let backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.22, alpha: 1)
        let textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        storyView.set(color: backgroundColor,
                      textColor: textColor,
                      title: "Отчет в свободной форме",
                      image: UIImage(named: "story"))
        audioView.set(color: backgroundColor,
                      textColor: textColor,
                      title: "Записать аудио",
                      image: UIImage(named: "mic"))
        attachmentsView.set(color: backgroundColor,
                            textColor: textColor,
                            title: "Прикрепить фото",
                            image: UIImage(named: "cam"))

        createButton.setTitleColor(UIColor(red: 0.17, green: 0.22, blue: 0.13, alpha: 1), for: .normal)
        createButton.backgroundColor = .white
        createButton.roundAllCorners(radius: 56.0)

        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.tintColor = UIColor(red: 0.34, green: 0.59, blue: 0.18, alpha: 1)
        textView.backgroundColor = .white
        storyView.fill(textView: textView)

        storyView.didTap = { [weak self] in
            self?.storyDeleteView.isHidden = false
        }

        audioView.didTap = { [weak self] in
            self?.audioDeleteView.isHidden = false
        }

        attachmentsView.didTap = { [weak self] in
            self?.showCameraPermission()
            self?.showPhotoLibraryPermission()
            self?.showPicker()

            self?.attachDeleteView.isHidden = false
        }

        storyDeleteView.roundAllCorners(radius: 56.0)
        audioDeleteView.roundAllCorners(radius: 56.0)
        attachDeleteView.roundAllCorners(radius: 56.0)

        storyDeleteView.isHidden = true
        audioDeleteView.isHidden = true
        attachDeleteView.isHidden = true
    }

    private func showPhotoLibraryPermission() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print("auth")
                } else {
                    print("else")
                }
            })
        }
    }

    func showCameraPermission() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                print("auth")
            } else {
                print("not")
            }
        }
    }

    func showPicker() {
        let pickerController = ImagePickerController()
        pickerController.imageLimit = 3
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
}

extension FeedbackViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {

    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.images = images
        attachmentsView.fill(images: images)
    }

    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        if images.count == 0 {
            attachDeleteView.isHidden = true
        } else {
            attachDeleteView.isHidden = false
        }
    }
}

// MARK: - KeyboardObservable, FullKeyboardPresentable

extension FeedbackViewController: KeyboardObservable, FullKeyboardPresentable {
    func keyboardWillBeShown(keyboardInfo: Notification.KeyboardInfo) {
        guard let height = keyboardInfo.frameEnd?.height,
            let duration = keyboardInfo.animationDuration else {
                return
        }

        scrollView.contentInset.bottom = height

        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    func keyboardWillBeHidden(keyboardInfo: Notification.KeyboardInfo) {
        guard let duration = keyboardInfo.animationDuration else { return }

        scrollView.contentInset.bottom = 0.0

        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

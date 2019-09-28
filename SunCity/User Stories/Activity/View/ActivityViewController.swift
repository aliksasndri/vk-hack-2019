//
//  ActivityViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class ActivityViewController: UIViewController, ActivityModuleOutput {

    // MARK: - Subviews

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleContainerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!

    @IBOutlet var titleContainerViews: [UIView]!
    @IBOutlet var subtitleContainerViews: [UIView]!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleContainer: UIView!
    @IBOutlet private weak var subtitleContainer: UIView!

    @IBOutlet weak var diaryButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!

    @IBOutlet weak var scrollViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewTrailingConstraint: NSLayoutConstraint!

    // MARK: - Properties

    var isShowingEvents: Bool = true

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.93, alpha: 1)
        titleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        titleContainer.cornerRadius = 24
        subtitleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        subtitleContainer.cornerRadius = 24
        updateButtons()

        tableView.register(
            UINib(nibName: String(describing: DiaryRecordCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: DiaryRecordCell.self)
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        titleContainerIndicator.hidesWhenStopped = true

        diaryButton.applyDropShadow()
        eventsButton.applyDropShadow()

        loadFeedback()
    }

    // MARK: - Actions

    @IBAction func eventsAction(_ sender: Any) {
        isShowingEvents = true
        scrollViewTrailingConstraint.constant = 0
        scrollViewLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        updateButtons()
    }

    @IBAction func diaryAction(_ sender: Any) {
        isShowingEvents = false
        scrollViewTrailingConstraint.constant = view.bounds.size.width
        scrollViewLeadingConstraint.constant = -view.bounds.size.width
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        updateButtons()
    }

    // MARK: - Private methods

    private func loadFeedback() {
        titleContainerIndicator.startAnimating()
        titleContainerViews.forEach { $0.isHidden = true }
        subtitleContainerViews.forEach { $0.isHidden = true }
        let service = FeedbackService()
        service.getAll(
            onSuccess: { response in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.titleContainerViews.forEach { $0.isHidden = false }
                    self.subtitleContainerViews.forEach { $0.isHidden = false }
                    self.titleContainerIndicator.stopAnimating()
                    self.usernameLabel.text = response.user.name
                    self.cityLabel.text = String(response.user.description.split(separator: "*").first ?? "")
                    self.workLabel.text = String(response.user.description.split(separator: "*").last ?? "")
                }
            },
            onError: {
                self.titleContainerIndicator.stopAnimating()
            }
        )
    }

    private func updateButtons() {
        diaryButton.alpha = isShowingEvents ? 0.3 : 1.0
        eventsButton.alpha = isShowingEvents ? 1.0 : 0.3
    }

}

extension ActivityViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ActivityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: DiaryRecordCell.self),
            for: indexPath
        ) as? DiaryRecordCell
        cell?.configure(
            minutesAudio: "4:11",
            commentsCount: "2",
            photosCount: "3",
            text: "Что сказать о моём друге? Иногда я вижу в ней себя. Бывает, я её не понимаю. Часто мне хочется дать ей больше. Регулярно думаю: \"А как это, видеть мир ее глазами?\" Она заставляет меня размышлять и смеяться, грустить и даже злиться на секунду.",
            date: "Сегодня"
        )
        return cell ?? UITableViewCell()
    }


}

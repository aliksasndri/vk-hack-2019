//
//  ActivityViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit
import Nuke
import SwiftMessages

final class ActivityViewController: UIViewController, ActivityModuleOutput {

    // MARK: - Subviews

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleContainerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var createEventButton: TouchableControl!

    @IBOutlet var eventsStubs: [UIView]!

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
    @IBOutlet weak var subtitleContainerHeight: NSLayoutConstraint!

    // MARK: - Properties

    var isShowingEvents: Bool = true
    var feedbacks: [Feedback] = []

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.applyTransparentStyle()

        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.93, alpha: 1)

        titleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        titleContainer.layer.cornerRadius = 24

        subtitleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        subtitleContainer.layer.cornerRadius = 24

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

        self.subtitleContainer.clipsToBounds = true
        self.subtitleContainer.layer.shadowColor = UIColor.black.cgColor
        self.subtitleContainer.layer.shadowOpacity = 0.5
        self.subtitleContainer.layer.shadowOffset = CGSize(width: -10, height: -10)
        self.subtitleContainer.layer.shadowRadius = 1
        self.subtitleContainer.layer.shadowRadius = 20
        self.subtitleContainer.layer.masksToBounds = false

        loadFeedback()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    @IBAction func feedbackButtonAction(_ sender: Any) {
        let (controller, _) = FeedbackModuleConfigurator().configure()
        present(controller, animated: true)
    }

    // MARK: - Private methods

    private func loadFeedback() {
        titleContainerIndicator.startAnimating()
        titleContainerViews.forEach { $0.isHidden = true }
        subtitleContainerViews.forEach { $0.isHidden = true }
        diaryButton.isHidden = true
        let service = FeedbackService()
        service.getAll(
            onSuccess: { response in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
                    self.eventsStubs.forEach { $0.isHidden = true }
                    self.titleContainerViews.forEach { $0.isHidden = false }
                    self.subtitleContainerViews.forEach { $0.isHidden = false }
                    self.titleContainerIndicator.stopAnimating()
                    self.usernameLabel.text = response.user.name
                    self.cityLabel.text = String(response.user.description.split(separator: "*").first ?? "")
                    self.workLabel.text = String(response.user.description.split(separator: "*").last ?? "")
                    self.avatarImageView.loadImage(
                        with: "http://demo6.alpha.vkhackathon.com:8844" + response.user.image,
                        placeholderImage: UIImage(named: "avatar_placeholder")
                    )
                    self.feedbacks = response.payload
                    self.tableView.reloadData()
                    switch response.user.userType {
                    case .mentor:
                        self.diaryButton.isHidden = false
                        UIView.animate(withDuration: 0.3) {
                            self.subtitleContainerHeight.constant = 191
                            self.view.layoutSubviews()
                        }
                    case .psychologist:
                        self.diaryButton.isHidden = true
                        self.createEventButton.isHidden = false
                        break
                    }

                }
            },
            onError: {
                self.titleContainerIndicator.stopAnimating()
                let view = MessageView()
                view.configureContent(body: "Кажется что-то сломалось.")
                SwiftMessages.sharedInstance.show(view: view)
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
        let viewController = PostDetailsModuleConfigurator().configure().0
        viewController.feedback = feedbacks[indexPath.row]
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ActivityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedbacks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: DiaryRecordCell.self),
            for: indexPath
        ) as? DiaryRecordCell
        let feedback = feedbacks[indexPath.row]
        cell?.configure(
            minutesAudio: feedback.audio == "" ? nil : "1",
            commentsCount: String(feedback.comments?.count ?? 0),
            photosCount: String(feedback.images.count),
            text: feedback.text,
            date: feedback.date.toWeekDayAndDateString()
        )
        return cell ?? UITableViewCell()
    }


}

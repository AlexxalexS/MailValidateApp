//
//  ViewController.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import UIKit

class VerificationViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let statusLabel = StatusLabel()
    private let mailTextField = MailTextField()
    private let verificationButton = VerificationButton()
    private let collectionView = MailsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private lazy var stackView = UIStackView(
        arrangedSubviews: [
            mailTextField,
            verificationButton,
            collectionView
        ],
        axis: .vertical,
        spacing: 20
    )

    private let verificationModel = VerificationModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotification()
        setupViews()
        setDelegates()
        setConstraints()
    }

    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        setupButtonTarget()
    }

    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }

    private func setupButtonTarget() {
        verificationButton.addTarget(self, action: #selector(verificationButtonTapped), for: .touchUpInside)
    }

    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.selectMailDelegate = self
        mailTextField.textFieldDelegate = self
    }

    @objc private func verificationButtonTapped() {
        checkVerification()
    }

    private func checkVerification() {
        guard let mail = mailTextField.text else { return }

        NetworkDataFetch.shared.fetchMail(verifiableMail: mail) { result, error in
            if error == nil {
                guard let result = result else {
                    return
                }

                if result.success {
                    guard let didYouMeanError = result.didYouMean else {
                        Alert.showResultAlert(vc: self, message: "Mail status: \(result.result) \n \(result.reasonDescription)")
                        return
                    }

                    Alert.showErrorAlert(
                        vc: self,
                        message: "Did you mean: \(didYouMeanError)"
                    ) { [weak self] in
                        guard let self = self else { return }
                        self.mailTextField.text = didYouMeanError
                    }
                }

            } else {
                guard let errorDescription = error?.localizedDescription else { return }
                Alert.showResultAlert(vc: self, message: errorDescription)
            }
        }
    }

    private func reloadCollectionView() {
        UIView.transition(
            with: collectionView,
            duration: 0.1,
            options: .transitionCrossDissolve
        ) {
            self.collectionView.reloadData()
        }
    }

}

// MARK: - UICollectionViewDataSource

extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filteredMailArray.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IdCell.idMailCell.rawValue,
                for: indexPath
            ) as? MailsCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let mailLabelText = verificationModel.filteredMailArray[indexPath.row]
        cell.cellConfigure(mailLabelText)

        return cell
    }
}

// MARK: - SelectProposedMailProtocol

extension VerificationViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {
        setupProposedMail(indexPath)
    }

    private func setupProposedMail(_ indexPath: IndexPath) {
        guard let text = mailTextField.text else { return }
        verificationModel.getMailName(text: text)
        let domainMail = verificationModel.filteredMailArray[indexPath.row]
        let mailFullName = verificationModel.nameMail + domainMail
        mailTextField.text = mailFullName
        updateViews(mailFullName)
    }

    private func updateViews(_ mail: String) {
        statusLabel.isValid = mail.isValid()
        verificationButton.isValid = mail.isValid()
        verificationModel.filteredMailArray = []
        reloadCollectionView()
    }

}

// MARK: - ActionsMailTextFieldProtocol

extension VerificationViewController: ActionsMailTextFieldProtocol {
    func typingText(text: String) {
        verificationModel.getFilteredMail(text: text)
        reloadCollectionView()
        setupValidation(text: text)
    }

    func cleanOutTextField() {
        setupCleanOutTextField()
    }

    private func setupValidation(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        if text == "" {
            setupCleanOutTextField()
        }
    }

    private func setupCleanOutTextField() {
        statusLabel.setDefaultSettings()
        verificationButton.setDefaultSettings()
        verificationModel.filteredMailArray = []
        reloadCollectionView()
    }
}

// MARK: - SetConstraints

extension VerificationViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}

//
//  MailsCollectionViewCell.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation
import UIKit

class MailsCollectionViewCell: UICollectionViewCell {

    private let domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.alpha = 0.7
        contentView.layer.cornerRadius = 12

        addSubview(domainLabel)
    }

    private func configure(_ mainLabelText: String) {
        domainLabel.text = mainLabelText
    }

    public func cellConfigure(_ mailLabelText: String) {
        configure(mailLabelText)
    }

}

extension MailsCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            domainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            domainLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

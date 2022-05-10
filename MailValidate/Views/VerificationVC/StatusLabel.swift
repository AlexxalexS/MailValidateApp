//
//  StatusLabel.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation
import UIKit

class StatusLabel: UILabel {

    public var isValid = false {
        didSet {
            if self.isValid {
                setValidSetting()
            } else {
                setNotValidSetting()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        text = "Check your mail"
        textColor = .labelTextColor
        font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setNotValidSetting() {
        text = "Mail is not valid. Example: name@domain.ru"
        textColor = .invalidColor
    }

    private func setValidSetting() {
        text = "Mail is valid"
        textColor = .validColor
    }

    public func setDefaultSettings() {
        configure()
    }

}

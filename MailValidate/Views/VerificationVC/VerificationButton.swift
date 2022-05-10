//
//  VerificationButton.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation
import UIKit

class VerificationButton: UIButton {

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
        backgroundColor = .buttonBackgroundColor
        setTitle("Verification Button", for: .normal)
        setTitleColor(.buttonTextColor, for: .normal)
        layer.cornerRadius = 12
        titleLabel?.font = UIFont(name: "Avenir Book", size: 17)
        isEnabled = false
        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setNotValidSetting() {
        isEnabled = false
        alpha = 0.5
    }

    private func setValidSetting() {
        isEnabled = true
        alpha = 1
    }

    public func setDefaultSettings() {
        configure()
    }

}

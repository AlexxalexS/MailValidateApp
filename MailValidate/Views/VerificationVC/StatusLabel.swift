//
//  StatusLabel.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation
import UIKit

class StatusLabel: UILabel {

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
        font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }

}

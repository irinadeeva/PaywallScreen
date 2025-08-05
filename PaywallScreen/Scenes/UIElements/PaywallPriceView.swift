//
//  PaywallPriceView.swift
//  PaywallScreen
//
//  Created by Irina Deeva on 05/08/25.
//
//

import UIKit

final class PaywallPriceView: UIView {
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let cancelLabel = UILabel()
    private let toggle = UISwitch()

    private var cancelWithDescriptionConstraint: NSLayoutConstraint!
    private var cancelWithoutDescriptionConstraint: NSLayoutConstraint!

    private var priceWithDescriptionConstraint : NSLayoutConstraint!
    private var priceWithoutDescriptionConstraint: NSLayoutConstraint!

    var onToggleChanged: ((Bool) -> Void)?

    init(price: String, description: String?, cancelText: String?) {
        super.init(frame: .zero)
        setupViews(price: price, description: description, cancelText: cancelText)
        setupLayout()
        setupActions()
        toggle.isOn = false
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupViews(price: String, description: String?, cancelText: String?) {
        backgroundColor = ColorManager.darkGray
        layer.cornerRadius = 24
        layer.masksToBounds = true

        toggle.isOn = false
        toggle.onTintColor = ColorManager.main
        toggle.backgroundColor = ColorManager.graysGray
        toggle.layer.cornerRadius = toggle.frame.height / 2
        toggle.clipsToBounds = true

        priceLabel.text = price
        priceLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        priceLabel.textColor = ColorManager.white

        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 11)
        descriptionLabel.textColor = ColorManager.main
        descriptionLabel.isHidden = (toggle.isOn == false)

        cancelLabel.text = cancelText
        cancelLabel.font = UIFont.systemFont(ofSize: 11)
        cancelLabel.textColor = ColorManager.gray
    }

    private func setupLayout() {
        [priceLabel,
         descriptionLabel,
         cancelLabel,
         toggle].forEach {
            addSubview( $0 )
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        priceWithDescriptionConstraint = priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        priceWithoutDescriptionConstraint = priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)

        cancelWithDescriptionConstraint = cancelLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2)
        cancelWithoutDescriptionConstraint = cancelLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4)

        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            priceWithoutDescriptionConstraint,

            descriptionLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),

            cancelWithoutDescriptionConstraint,
            cancelLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),

            toggle.centerYAnchor.constraint(equalTo: centerYAnchor),
            toggle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupActions() {
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
    }

    @objc private func toggleChanged() {
        onToggleChanged?(toggle.isOn)
    }

    func setDescriptionVisible(_ visible: Bool, text: String? = nil) {
        descriptionLabel.isHidden = !visible
        if let text = text { descriptionLabel.text = text }

        if visible {
            priceWithoutDescriptionConstraint.isActive = false
            priceWithDescriptionConstraint.isActive = true

            cancelWithoutDescriptionConstraint.isActive = false
            cancelWithDescriptionConstraint.isActive = true
        } else {
            priceWithoutDescriptionConstraint.isActive = true
            priceWithDescriptionConstraint.isActive = false

            cancelWithDescriptionConstraint.isActive = false
            cancelWithoutDescriptionConstraint.isActive = true
        }

        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }

    func setToggleOn(_ on: Bool) {
        toggle.setOn(on, animated: true)
    }
}

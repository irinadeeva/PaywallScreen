//
//  ViewController.swift
//  PaywallScreen
//
//  Created by Irina Deeva on 05/08/25.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - UI Elements
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "maki_cross"), for: .normal)
        return button
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "hand"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let infoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "conditions"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let subscribeButton = PaywallPriceView(
        price: "$5.99/week",
        description: "Start with 3-Day Free Trial",
        cancelText: "Cancel anytime"
    )

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(ColorManager.bg, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = 24
        button.backgroundColor = ColorManager.main
        return button
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private let footerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupActions()
    }
}

private extension ViewController {
    func setupLayout() {
        let gradientLayer = CAGradientLayer.gradientLayer(for: [ColorManager.bg.cgColor, ColorManager.filling.cgColor], in: view.frame)
        view.layer.addSublayer(gradientLayer)

        [closeButton,
         imageView,
         infoView,
         buttonsStackView,
         footerStack].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [subscribeButton,
         continueButton].forEach {
            buttonsStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setupFooter()

        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),

            imageView.heightAnchor.constraint(equalToConstant: 118),
            imageView.widthAnchor.constraint(equalToConstant: 88),
            imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            infoView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 48),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),

            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            buttonsStackView.bottomAnchor.constraint(equalTo: footerStack.topAnchor, constant: -24),

            subscribeButton.heightAnchor.constraint(equalToConstant: 72),
            continueButton.heightAnchor.constraint(equalToConstant: 72),

            footerStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            footerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupActions() {
        subscribeButton.onToggleChanged = { [weak self] isOn in
            guard let self = self else { return }
            if isOn {
                self.continueButton.setTitle("Start Free Trial", for: .normal)
                self.subscribeButton.setDescriptionVisible(true, text: "Start with 3-Day Free Trial")
            } else {
                self.continueButton.setTitle("Continue", for: .normal)
                self.subscribeButton.setDescriptionVisible(false)
            }
        }
    }

    func setupFooter() {
        let terms = UIButton(type: .system)
        terms.setTitle("Terms", for: .normal)
        terms.setTitleColor(ColorManager.gray, for: .normal)
        terms.titleLabel?.font = .systemFont(ofSize: 13)
        footerStack.addArrangedSubview(terms)

        let privacy = UIButton(type: .system)
        privacy.setTitle("Privacy", for: .normal)
        privacy.setTitleColor(ColorManager.gray, for: .normal)
        privacy.titleLabel?.font = .systemFont(ofSize: 13)
        footerStack.addArrangedSubview(privacy)

        let subscription = UIButton(type: .system)
        subscription.setTitle("Subscription Policy", for: .normal)
        subscription.setTitleColor(ColorManager.gray, for: .normal)
        subscription.titleLabel?.font = .systemFont(ofSize: 13)
        footerStack.addArrangedSubview(subscription)
    }
}

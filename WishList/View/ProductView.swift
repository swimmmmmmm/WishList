//
//  ProductView.swift
//  WishList
//
//  Created by 서수영 on 4/12/24.
//

import UIKit

class ProductView: UIView {

    lazy var conatinerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionTextView, priceLabel, buttonStackView, showListButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        stackView.setCustomSpacing(4, after: buttonStackView)

        return stackView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 20, weight: .medium)

        return textView
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .right

        return label
    }()

    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addListButton, showNextButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        stackView.spacing = 8

        return stackView
    }()

    let addListButton: UIButton = {
        let button = UIButton()
        button.setTitle("위시 리스트 담기", for: .normal)

        button.backgroundColor = .green
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        return button
    }()

    let showNextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다른 상품 보기", for: .normal)

        button.backgroundColor = .red
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        return button
    }()

    let showListButton: UIButton = {
        let button = UIButton()
        button.setTitle("위시 리스트 보기", for: .normal)
        button.backgroundColor = .lightGray
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUp() {
        self.addSubview(conatinerStackView)
        self.backgroundColor = .white

        NSLayoutConstraint.activate([
            conatinerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            conatinerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            conatinerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            conatinerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }


}

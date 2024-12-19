//
//  HomeEmptyStateCell.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-19.
//

import UIKit

final class HomeEmptyStateCell: UICollectionViewCell {
    static let identifier = "HomeEmptyStateCell"

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fp500
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "데이터가 없습니다."
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with title: String, andSize size: CGFloat) {
        messageLabel.text = title
        messageLabel.font = UIFont.systemFont(ofSize: size)
    }
}

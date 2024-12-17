//
//  BookingViewController.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import SnapKit
import UIKit

final class BookingViewController: UIViewController {

    private let formatOptionCollectionView: FormatOptionCollectionView = .init()
    private let timeOptionCollectionView: TimeOptionCollectionView = .init()

    private var selectedFormat: UIButton?
    private var selectedTime: UIButton?

    private let formatOptions = ["2D", "3D", "IMAX"]
    private let timeOptions = [
        "09:30 AM", "10:30 AM", "11:30 AM",
        "12:30 PM", "02:30 PM", "03:30 PM",
        "04:30 PM", "05:30 PM", "06:30 PM",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionViews()
        setConstraints()
    }

    private func setCollectionViews() {
        formatOptionCollectionView.register(FormatOptionCell.self,
                                            forCellWithReuseIdentifier: FormatOptionCell.id)
        formatOptionCollectionView.dataSource = self
        formatOptionCollectionView.delegate = self

        timeOptionCollectionView.register(TimeOptionCell.self,
                                          forCellWithReuseIdentifier: TimeOptionCell.id)
        timeOptionCollectionView.dataSource = self
        timeOptionCollectionView.delegate = self
        
        view.addSubview(formatOptionCollectionView)
        view.addSubview(timeOptionCollectionView)
    }
    
    private func setConstraints() {
        timeOptionCollectionView.frame = view.bounds
    }
}

extension BookingViewController: FormatOptionCellDelegate {
    func formatOptionTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }

        print("tapped: \(title)")

        if let previousButton = selectedFormat {
            UIView.animate(withDuration: 0.3) {
                previousButton.backgroundColor = .available
                previousButton.tintColor = .availableText
            }
        }

        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .selected
            sender.tintColor = .selectedText
        }

        selectedFormat = sender
    }
}

extension BookingViewController: TimeOptionCellDelegate {

    func timeOptionTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }

        print("tapped: \(title)")

        if let previousButton = selectedTime {
            UIView.animate(withDuration: 0.3) {
                previousButton.backgroundColor = .available
                previousButton.tintColor = .availableText
            }
        }

        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .selected
            sender.tintColor = .selectedText
        }

        selectedTime = sender
    }

}

extension BookingViewController: UICollectionViewDataSource,
    UICollectionViewDelegate
{

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return timeOptions.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: TimeOptionCell.id,
                for: indexPath) as! TimeOptionCell

        cell.setButton(to: timeOptions[indexPath.item], delegate: self)

        return cell
    }

}

extension BookingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let numberOfCellsInRow: CGFloat = 3
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (numberOfCellsInRow - 1)

        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = availableWidth / numberOfCellsInRow

        return CGSize(width: cellWidth, height: 50)
    }
}

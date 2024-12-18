//
//  DateOptionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
//

import UIKit

import SnapKit
import Then

final class DateOptionView: UIView {
    
    var selectedDate: UIButton?
    
    private let dateOptionCollectionView: DateOptionCollectionView = .init()
    private let dateOptions = [
        "15\n일",
        "16\n월",
        "17\n화",
        "18\n수",
        "19\n목",
        "20\n금",
        "21\n토",
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateOptionCollectionView.register(DateOptionCell.self,
                                          forCellWithReuseIdentifier: DateOptionCell.id)
        dateOptionCollectionView.dataSource = self
        dateOptionCollectionView.delegate = self
        // TO-DO: enable scroll?
        dateOptionCollectionView.isScrollEnabled = true
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(dateOptionCollectionView)
    }
    
    private func setConstraints() {
        dateOptionCollectionView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
}

extension DateOptionView: DateOptionCellDelegate {
    func dateOptionTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        print("selected date: \(title)")
        
        if let previousButton = selectedDate {
            UIView.animate(withDuration: 0.3) {
                previousButton.backgroundColor = .available
                previousButton.tintColor = .fp300
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .fpIvory
            sender.tintColor = .fp700
        }
        
        selectedDate = sender
    }
}

extension DateOptionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dateOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateOptionCell.id, for: indexPath) as! DateOptionCell
        
        cell.setButton(to: dateOptions[indexPath.item], delegate: self)
        
        return cell
    }
    
}

extension DateOptionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let numberOfCellsInRow: CGFloat = 7
        let spacing: CGFloat = 3
        let totalSpacing = spacing * (numberOfCellsInRow - 1)

        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = availableWidth / numberOfCellsInRow

        return CGSize(width: cellWidth, height: 60)
    }
}

//
//  DateOptionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
//

import UIKit

import SnapKit
import Then

protocol DateOptionViewDelegate: AnyObject {
    func dateTapped(_ sender: DateButton)
}

final class DateOptionView: UIView {
    
    weak var delegate: DateOptionViewDelegate?
    var selectedDate: DateButton?
    
    private let dateOptionTitle = UILabel().then {
        $0.text = "상영 날짜"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .left
    }
    
    private let dateOptionCollectionView: DateOptionCollectionView = .init()
    private var dateOptions: [Date] = []
    
    convenience init(with dateOptions: [Date]) {
        self.init()
        self.dateOptions = dateOptions
        print("DateOptionView: \(dateOptions)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateOptionCollectionView.register(DateOptionCell.self,
                                          forCellWithReuseIdentifier: DateOptionCell.id)
        dateOptionCollectionView.dataSource = self
        dateOptionCollectionView.delegate = self
        // TO-DO: enable scroll?
        dateOptionCollectionView.isScrollEnabled = true
        backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(to target: DateOptionViewDelegate) {
        self.delegate = target
    }
    
    private func addSubviews() {
        addSubview(dateOptionTitle)
        addSubview(dateOptionCollectionView)
    }
    
    private func setConstraints() {
        dateOptionTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        dateOptionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateOptionTitle.snp.bottom).offset(10)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}

extension DateOptionView: DateOptionCellDelegate {
    func dateOptionTapped(_ sender: DateButton) {
        guard let date = sender.date else { return }
        
        print("selected date: \(date.dayOnly) \(date.weekdayOnly)")
        
        if let previousButton = selectedDate {
            UIView.animate(withDuration: 0.3) {
                previousButton.backgroundColor = .available
                previousButton.tintColor = .fp500
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .fpIvory
            sender.tintColor = .fp900
        }
        delegate?.dateTapped(sender)
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

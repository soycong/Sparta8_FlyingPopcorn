//
//  TimeOptionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/17/24.
//

import UIKit

import SnapKit

final class TimeOptionView: UIView {
    
    var selectedTime: DateButton?
    
    private let timeOptionTitle = UILabel().then {
        $0.text = "상영 시간"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .left
    }
    private let timeOptionCollectionView: TimeOptionCollectionView = .init()
    private var timeOptions: [Date] = []
    
    convenience init(with timeOptions: [Date]) {
        self.init()
        self.timeOptions = []
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeOptionCollectionView.register(TimeOptionCell.self,
                                          forCellWithReuseIdentifier: TimeOptionCell.id)
        timeOptionCollectionView.dataSource = self
        timeOptionCollectionView.delegate = self
        timeOptionCollectionView.isScrollEnabled = false
        
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(timeOptionTitle)
        addSubview(timeOptionCollectionView)
    }
    
    private func setConstraints() {
        timeOptionTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        timeOptionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(timeOptionTitle.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setTimeOptions(with options: [Date]) {
        timeOptions = options
    }
    
    func resetCells() {
        selectedTime?.backgroundColor = .available
        selectedTime?.tintColor = .availableText
        
        timeOptionCollectionView.reloadData()
    }
    
    func resetTimeOptions() {
        timeOptions = []
    }
    
}

extension TimeOptionView: TimeOptionCellDelegate {
    func timeOptionTapped(_ sender: DateButton) {
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

extension TimeOptionView: UICollectionViewDataSource, UICollectionViewDelegate {

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

extension TimeOptionView: UICollectionViewDelegateFlowLayout {
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

        return CGSize(width: cellWidth, height: 45)
    }
}

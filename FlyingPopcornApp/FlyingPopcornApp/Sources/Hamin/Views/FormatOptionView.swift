//
//  FormatOptionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/17/24.
//

import UIKit

import SnapKit

final class FormatOptionView: UIView {
   
    var selectedFormat: UIButton?
    
    private let formatOptionTitle = UILabel().then {
        $0.text = "관람 가능 포맷"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .left
    }
    private let formatOptionCollectionView: FormatOptionCollectionView = .init()
    private var formatOptions: [String] = []
    
    convenience init(with formatOptions: [String]) {
        self.init()
        self.formatOptions = formatOptions
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        formatOptionCollectionView.register(FormatOptionCell.self,
                                            forCellWithReuseIdentifier: FormatOptionCell.id)
        formatOptionCollectionView.dataSource = self
        formatOptionCollectionView.delegate = self
        formatOptionCollectionView.isScrollEnabled = false
        
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(formatOptionTitle)
        addSubview(formatOptionCollectionView)
    }
    
    private func setConstraints() {
        formatOptionTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        formatOptionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(formatOptionTitle.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension FormatOptionView: FormatOptionCellDelegate {
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

extension FormatOptionView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return formatOptions.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: FormatOptionCell.id,
                for: indexPath) as! FormatOptionCell

        cell.setButton(to: formatOptions[indexPath.item], delegate: self)

        return cell
    }

}

extension FormatOptionView: UICollectionViewDelegateFlowLayout {
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

        return CGSize(width: cellWidth, height: 40)
    }
}


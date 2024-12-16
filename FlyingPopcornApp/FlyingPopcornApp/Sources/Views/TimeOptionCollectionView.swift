//
//  TimeOptionCollectionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit
import Then

final class TimeOptionCollectionView: UICollectionView {
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol TimeOptionCellDelegate: AnyObject {
    func cellTapped(_ title: String)
}

final class TimeOptionCell: UICollectionViewCell {
    
    weak var delegate: TimeOptionCellDelegate?
    static let id = "TimeOptionCell"
    
    private let timeOptionButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .redLight1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(timeOptionButton)
        
        setConstraints()
        
        timeOptionButton.addTarget(self,
                                   action: #selector(onTap),
                                   for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        timeOptionButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setButton(to title: String, delegate: TimeOptionCellDelegate?) {
        timeOptionButton.setTitle(title, for: .normal)
        self.delegate = delegate
    }
    
    @objc private func onTap() {
        guard let title = timeOptionButton.title(for: .normal) else { return }
        delegate?.cellTapped(title)
    }
}

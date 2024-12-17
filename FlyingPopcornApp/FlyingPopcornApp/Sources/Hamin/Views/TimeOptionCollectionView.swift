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
    func timeOptionTapped(_ sender: UIButton)
}

final class TimeOptionCell: UICollectionViewCell {
    
    weak var delegate: TimeOptionCellDelegate?
    static let id = "TimeOptionCell"
    
    private let timeOptionButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .available
        $0.tintColor = .availableText
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
    
    // 
    @objc private func onTap(_ sender: UIButton) {
        
        delegate?.timeOptionTapped(sender)
        
    }
    
}



extension UIColor {
    static let available = UIColor(named: "redLight1")!
    static let unavailable = UIColor(named: "greyLight3")!
    static let selected = UIColor(named: "red")!

    static let availableText = UIColor(named: "greyLight3")!
    static let unavailableText = UIColor(named: "greyLight1")!
    static let selectedText = UIColor(named: "white")!
}

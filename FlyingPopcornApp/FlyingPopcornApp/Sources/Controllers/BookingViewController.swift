//
//  BookingViewController.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

final class BookingViewController: UIViewController {
    
    private let collectionView: TimeOptionCollectionView = .init()
    let options = [
        "09:30 AM", "10:30 AM", "11:30 AM",
        "12:30 PM", "02:30 PM", "03:30 PM",
        "04:30 PM", "05:30 PM", "06:30 PM",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TimeOptionCell.self, forCellWithReuseIdentifier: TimeOptionCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

extension BookingViewController: UICollectionViewDataSource, UICollectionViewDelegate, TimeOptionCellDelegate {
    func cellTapped(_ title: String) {
        print("tapped: \(title)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeOptionCell.id,
                                                      for: indexPath) as! TimeOptionCell
        
        cell.setButton(to: options[indexPath.item], delegate: self)
        
        return cell
    }
    
    
}


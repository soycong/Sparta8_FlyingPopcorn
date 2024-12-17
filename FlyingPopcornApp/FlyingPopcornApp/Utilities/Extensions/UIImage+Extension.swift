//
//  UIImage+Extension.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/17/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from url: URL) {
        // URLSession을 통해 URL에서 비동기적으로 데이터를 가져오는 방법
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
    
    /**
    func loadImageByKF(from url: String) {
        guard let url = URL(string: url) else { return }
        // Kignfisher를 통해 URL에서 비동기적으로 데이터를 가져오는 방법
        self.kf.setImage(with: url, options: [
            .cacheOriginalImage  // 원본 이미지를 캐시하도록 설정
        ]) { result in
            switch result {
            case .success(let value):
                print("이미지 로딩 성공\(value.image)")
            case .failure(let error):
                print("이미지 로딩 실패\(error.localizedDescription)")
            }
            
        }
    }
    */
}

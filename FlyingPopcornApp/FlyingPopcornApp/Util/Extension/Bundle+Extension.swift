//
//  Bundle+Extension.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/16/24.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}

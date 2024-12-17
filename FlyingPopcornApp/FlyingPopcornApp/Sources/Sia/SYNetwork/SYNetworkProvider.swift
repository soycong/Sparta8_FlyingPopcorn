//
//  SYNetworkProvider.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

final class SYNetworkProvider {
    private let endPoint: String
    
    init() {
        self.endPoint = "https://api.themoviedb.org/3"
    }
    
    func makeMovieNetwork() -> SYMovieNetwork {
        let network = SYNetwork<SYMovieListModel>(endPoint: endPoint)
        return SYMovieNetwork(network: network)
    }
}

//
//  SYNetworkProvider.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

final class NetworkProvider {
    private let endPoint: String
    
    init() {
        self.endPoint = "https://api.themoviedb.org/3"
    }
    
    func makeMovieNetwork() -> MovieNetwork {
        let network = Network<MovieListModel>(endPoint: endPoint)
        return MovieNetwork(network: network)
    }
}

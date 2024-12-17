//
//  SYMovieNetwork.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

final class SYMovieNetwork {
    private let network: SYNetwork<SYMovieListModel>
    
    init(network: SYNetwork<SYMovieListModel>) {
        self.network = network
    }
    
    func getUpcomingMovies(completion: @escaping (Result<SYMovieListModel, Error>) -> Void) {
        network.getMovieList(path: "movie/upcoming", completion: completion)
    }
    
    // 영화 상세 정보 가져오기
    func getMovieDetail(movieID: Int, completion: @escaping (Result<SYMovie, Error>) -> Void) {
        network.getMovieDetail(movieID: movieID, completion: completion)
    }
}

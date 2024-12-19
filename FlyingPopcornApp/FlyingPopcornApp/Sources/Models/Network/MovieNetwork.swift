//
//  MovieNetwork.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

final class MovieNetwork {
    private let network: Network<MovieListModel>
    
    init(network: Network<MovieListModel>) {
        self.network = network
    }
    
    func getNowPlayingList(completion: @escaping (Result<MovieListModel, Error>) -> Void) {
        network.getMovieList(path: "movie/now_playing", completion: completion)
    }
    
    func getPopularList(completion: @escaping (Result<MovieListModel, Error>) -> Void) {
        network.getMovieList(path: "movie/popular", completion: completion)
    }
    
    func getUpcomingMovies(completion: @escaping (Result<MovieListModel, Error>) -> Void) {
        network.getMovieList(path: "movie/upcoming", completion: completion)
    }
    
    // 영화 상세 정보 가져오기
    func getMovieDetail(movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        network.getMovieDetail(movieID: movieID, completion: completion)
    }
}

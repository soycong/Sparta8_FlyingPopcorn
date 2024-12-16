//
//  SYMovie.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

struct SYMovieListModel: Decodable {
    let results: [SYMovie]
}

struct SYMovie: Decodable, Hashable {
    let adult: Bool
    let id: Int
    let genreIDS: [Int]
    let genres: [String]
    let title: String
    let overview: String
    let posterURL: String
    let vote: String
    let voteAverage: Double
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case id
        case genreIDS = "genre_ids"
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    init(adult: Bool, id: Int, genreIDS: [Int], genres: [String], title: String, overview: String, posterURL: String, vote: String, voteAverage: Double, releaseDate: String) {
        self.adult = adult
        self.id = id
        self.genreIDS = genreIDS
        self.genres = genres
        self.title = title
        self.overview = overview
        self.posterURL = posterURL
        self.vote = vote
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        adult = try container.decode(Bool.self, forKey: .adult)
        id = try container.decode(Int.self, forKey: .id)
        genreIDS = try container.decode([Int].self, forKey: .genreIDS)
        
        genres = genreIDS.compactMap { genreID in
            SYMovie.genreMap[genreID] // 매핑된 장르 이름
        }
        
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        
        let path = try container.decode(String.self, forKey: .posterPath)
        posterURL = "https://image.tmdb.org/t/p/w500\(path)"
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount))"
        
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
    
    private static let genreMap: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
}

//
//  SYMovie.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

struct MovieListModel: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Hashable {
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
    let runtime: Int?
    
    // Custom CodingKeys to handle different API endpoint structures
    private enum CodingKeys: String, CodingKey {
        case adult
        case id
        case genreIDS = "genre_ids"
        case genres
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case runtime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        adult = try container.decode(Bool.self, forKey: .adult)
        id = try container.decode(Int.self, forKey: .id)
        
        if let genreObjects = try? container.decode([Genre].self, forKey: .genres) {
            genreIDS = genreObjects.map { $0.id }
            genres = genreObjects.map { $0.name }
        } else if let genreIDS = try? container.decode([Int].self, forKey: .genreIDS) {
            self.genreIDS = genreIDS
            genres = genreIDS.compactMap { Movie.genreMap[($0)] }
        } else {
            genreIDS = []
            genres = []
        }
        
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        
        let posterPath = try? container.decode(String.self, forKey: .posterPath)
        posterURL = posterPath != nil ? "https://image.tmdb.org/t/p/w500\(posterPath!)" : ""
        
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount))"
        
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        runtime = try? container.decode(Int.self, forKey: .runtime)
    }
    
    // Helper struct to decode genre objects
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
    
    // Existing genre mapping
    static let genreMap: [Int: String] = [
        28: "액션",
        12: "어드벤처",
        16: "애니메이션",
        35: "코미디",
        80: "범죄",
        99: "다큐멘터리",
        18: "드라마",
        10751: "가족",
        14: "판타지",
        36: "역사",
        27: "공포",
        10402: "음악",
        9648: "미스터리",
        10749: "로맨스",
        878: "픽션",
        10770: "TV Movie",
        53: "스릴러",
        10752: "전쟁",
        37: "서부"
    ]
    
    // Default initializer
    init(adult: Bool, id: Int, genreIDS: [Int], genres: [String], title: String, overview: String, posterURL: String, vote: String, voteAverage: Double, releaseDate: String, runtime: Int) {
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
        self.runtime = runtime
    }
}

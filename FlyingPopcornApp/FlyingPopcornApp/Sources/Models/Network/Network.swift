//
//  SYNetwork.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import Foundation

import Alamofire

final class Network<T: Decodable> {
    private let endPoint: String
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key not found in xcconfig!")
        }
        return key
    }
    
    init(endPoint: String) {
        self.endPoint = endPoint
    }
    
    // 영화 목록 가져오기
    func getMovieList(path: String, language: String = "ko", completion: @escaping (Result<T, Error>) -> Void) {
        let fullPath = "\(endPoint)/\(path)?api_key=\(apiKey)&language=\(language)"
        print("Full API Request Path: \(fullPath)")
        
        guard let url = URL(string: fullPath) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodeData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodeData))
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("API Failed: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    // 영화 상세 정보 가져오기
    func getMovieDetail(movieID: Int, language: String = "ko", completion: @escaping (Result<Movie, Error>) -> Void) {
        let fullPath = "\(endPoint)/movie/\(movieID)?api_key=\(apiKey)&language=\(language)"
        print("Full API Request Path: \(fullPath)")
        
        AF.request(fullPath, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodeData = try JSONDecoder().decode(Movie.self, from: data)
                        completion(.success(decodeData))
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("API Failed: \(error)")
                    completion(.failure(error))
                }
            }
    }
}

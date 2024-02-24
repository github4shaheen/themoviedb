// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import TMDBSchemeModels
import CoreNetwork

public protocol TrendingRepoProtocol {
    func fetchTrendingMovies(page: Int,completion: @escaping (Result<TrendingResponse, APIClientErrors>) -> Void)
}

public class TrendingRepo: TrendingRepoProtocol {
    
    public init() {}
    
    public func fetchTrendingMovies(page:Int, completion: @escaping (Result<TrendingResponse, APIClientErrors>) -> Void) {
        let endPoint = TrendingEndPoint.trending(page: page)
        APIClient.shared.request(with: endPoint) { (result: Result<TrendingResponse, APIClientErrors>) in
            switch result {
            case let .success(response):
                debugPrint("We got a successful result with \(response.page) pages.")
                completion(.success(response))
            case .failure(let error):
                debugPrint("We got a failure trying to get the movies. The error we got was: \(error.localizedDescription)")
                completion(.failure(error))
            }
         }
    }
}

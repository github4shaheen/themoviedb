// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import TMDBSchemeModels
import CoreNetwork

public protocol MovieDetailsRepoProtocol {
    func fetchMovieDetails(with id: String, completion: @escaping (Result<MovieDetails, APIClientErrors>) -> Void)
}

public class  MovieDetailsRepo: MovieDetailsRepoProtocol {
   
    public init() {}
    
    public func fetchMovieDetails(with id: String, completion: @escaping (Result<MovieDetails, APIClientErrors>) -> Void) {
        let endPoint = MovieDetailsEndPoint.movie(id: id)
        APIClient.shared.request(with: endPoint) { (result: Result<MovieDetails, APIClientErrors>) in
            switch result {
            case let .success(movie):
                debugPrint("We got a successful result for movie with id \(movie.id).")
                completion(.success(movie))
            case let .failure(error):
                debugPrint("We got a failure trying to get the movies. The error we got was: \(error.localizedDescription)")
                completion(.failure(error))
            }
         }
    }
}

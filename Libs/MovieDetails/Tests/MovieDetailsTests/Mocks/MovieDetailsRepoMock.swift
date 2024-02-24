// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
@testable import MovieDetails
import TMDBRepo
import CoreNetwork
import TMDBSchemeModels


class MovieDetailsRepoMock: MovieDetailsRepoProtocol {
    var fetchMovieCalled = false
    var shouldFetchMovieSucceed = true
    var error: APIClientErrors = .noResponse
    
    func fetchMovieDetails(with id: String, completion: @escaping (Result<MovieDetails, APIClientErrors>) -> Void) {
        let movie = MovieDetailsMockGenerator.simpleMovie
        if shouldFetchMovieSucceed {
            completion(.success(movie))
        } else {
            completion(.failure(error))
        }
        fetchMovieCalled = true
    }
    
    
}

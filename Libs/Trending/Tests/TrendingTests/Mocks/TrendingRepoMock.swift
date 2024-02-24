// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
@testable import Trending
import TMDBRepo
import CoreNetwork
import TMDBSchemeModels

class TrendingRepoMock: TrendingRepoProtocol {
    
    var fetchMovieCalled = false
    var shouldFetchMoviesSucceed = true
    var error: APIClientErrors = .noResponse
        
    func fetchTrendingMovies(page: Int, completion: @escaping (Result<TrendingResponse, CoreNetwork.APIClientErrors>) -> Void) {
        let movies = MoviesMockGenerator.generateMovieList(page: page)
        let response = TrendingResponse(page: 1, totalPages: 50, totalResults: 1000, results: movies)
        
        if shouldFetchMoviesSucceed {
            completion(.success(response))
        } else {
            completion(.failure(error))
        }
        
        fetchMovieCalled = true
    }

}

// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
@testable import Trending
import TMDBSchemeModels

class MoviesMockGenerator {
    static var simpleMovie: Movie {
        Movie.init(id: 1, title: "mojombo", posterPath: "simple.png", releaseDate: "2024")
    }
    
    static var movieJson: String {
        """
          {
            "title": "mojombo",
            "id": 1,
            "poster": "simple.png",
            "release_year": "2024"
          }
        """
    }
    
    static func generateUserFromJSON() -> Movie? {
        Movie(JSONString: movieJson)
    }
    
    static func generateMovieList(page: Int) -> [Movie] {
        return Array(repeating: simpleMovie, count: 20)
    }
}

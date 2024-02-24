// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
@testable import MovieDetails
import TMDBSchemeModels


class MovieDetailsMockGenerator {
    static var simpleMovie: MovieDetails {
        return MovieDetails(id: 1,
                     title: "mojombo",
                     posterPath: "simple.png",
                            overview: "Movie Overview", releaseDate: "2024-01-26")
    }
    
    static var movieJson: String {
        """
          {
            "title": "mojombo",
            "id": 1,
            "poster": "simple.png",
            "release_year": "2024-01-26",
            "overview": "Movie Overview"

          }
        """
    }
        
    static func generateMovieDetails() -> MovieDetails? {
        return MovieDetails(JSONString: movieJson)
    }
    
    static var movieHeader: MovieHeader {       
        return MovieHeader(id: 1,
                           title: "mojombo",
                           releaseYear: "2024-01-26",
                           poster: "simple.png",
                           overview: "Movie Overview")
    }
    
}

// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import TMDBSchemeModels


extension MovieDetails {    
    func head() -> MovieHeader {
        return MovieHeader(id: id, title: title, releaseYear: releaseYear, poster: poster, overview: overview)
    }
}

// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


public struct MovieDetails: Codable {

    public let id: Int
    public let title: String
    public let posterPath: String
    public var overview: String
    public var releaseDate: String


    public init(id: Int, title: String, posterPath: String, overview: String, releaseDate: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}


public extension MovieDetails {
    var poster: String {
        return "https://image.tmdb.org/t/p/w92/\(posterPath)"
    }
    
    var releaseYear: String {
        return releaseDate.components(separatedBy: "-").first ?? ""
    }
}

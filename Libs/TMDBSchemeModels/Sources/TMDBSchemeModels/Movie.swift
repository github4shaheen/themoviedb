// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let posterPath: String
    public var releaseDate: String

    public init(id: Int, title: String, posterPath: String, releaseDate: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}


public extension Movie {
    var poster: String {
        return "https://image.tmdb.org/t/p/w92/\(posterPath)"
    }
    
    var releaseYear: String {
        return releaseDate.components(separatedBy: "-").first ?? ""
    }
}

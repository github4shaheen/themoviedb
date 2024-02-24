// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import CoreNetwork

enum MovieDetailsEndPoint {
    case movie(id: String)
}

extension MovieDetailsEndPoint: RequestProtocol {
    var baseURL: String {
        "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case let .movie(id):
            return "/3/movie/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .movie:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDZhZDUxN2QyYWI0YTUyMTE2ZTQ1ZmNiMTE1YTc5MiIsInN1YiI6IjY1ZDg2M2VjMmRhODQ2MDE4NzcxYTgxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.R_hW-AA5jHzoJT5WCrceGcwg1wAVExypI-BkSRzvb50"
        ]
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .movie:
            return [
                URLQueryItem(name: "language", value: "en-US")
            ]
        }
    }
}

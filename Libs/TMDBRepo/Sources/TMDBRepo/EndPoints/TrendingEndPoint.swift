// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import CoreNetwork

enum TrendingEndPoint {
    case trending(page: Int)
}

extension TrendingEndPoint: RequestProtocol {
    var baseURL: String {
       "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/3/discover/movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .trending:
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
        case let .trending(page):
            return [
                URLQueryItem(name: "include_adult", value: "\(false)"),
                URLQueryItem(name: "include_video", value: "\(false)"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
            ]
        }
    }
}


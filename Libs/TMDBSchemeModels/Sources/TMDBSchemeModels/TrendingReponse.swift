// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


public struct TrendingResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
    
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    public let results: [Movie]


    public init(page: Int, totalPages: Int, totalResults: Int, results: [Movie]) {
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.results = results
    }
}

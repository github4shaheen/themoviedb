// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

class ResponseModelMock: Codable {
    var key: String?
    
    enum CodingKeys: String, CodingKey {
        case key
    }
}

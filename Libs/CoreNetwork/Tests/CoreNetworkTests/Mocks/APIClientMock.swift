// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import CoreNetwork

class APIClientMock: APIClientProtocol {
    var session: URLSessionProtocol = URLSession.shared
}

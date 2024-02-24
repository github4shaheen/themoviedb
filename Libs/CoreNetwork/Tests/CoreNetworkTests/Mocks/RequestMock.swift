// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import CoreNetwork

class RequestMock: RequestProtocol {
    var baseURL: String = "https://www.mock.com"
    var path: String = "/mock/path"
    var httpMethod: HTTPMethod = .get
    var headers: HTTPHeaders? = [:]
    var parameters: [URLQueryItem]? = []
    var timeoutInterval: TimeInterval = 15.0
}

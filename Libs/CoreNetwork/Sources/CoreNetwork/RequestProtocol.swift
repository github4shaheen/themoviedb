// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public typealias HTTPHeaders = [String: String]

public protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [URLQueryItem]?  { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
}

public  extension RequestProtocol {
    var headers: HTTPHeaders? {
        return [:]
    }
    
    var urlComponents: URLComponents? {
        var component = URLComponents(string: baseURL)
        component?.path = path
        if parameters?.isEmpty == false {
            component?.queryItems = parameters
        }
        return component
    }
    
    var cachePolicy: NSURLRequest.CachePolicy{
        .reloadIgnoringCacheData
    }
    
    var timeoutInterval: TimeInterval {
        return 20.0
    }
}

public  enum HTTPMethod: String {
    case get = "GET"
}

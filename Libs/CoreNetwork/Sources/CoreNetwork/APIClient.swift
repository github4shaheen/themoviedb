// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class APIClient{

    public static let shared = APIClient()
    
    public var session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

extension APIClient: APIClientProtocol {}

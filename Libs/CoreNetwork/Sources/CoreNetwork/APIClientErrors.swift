// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public enum APIClientErrors: Error, LocalizedError {
    case badURL
    case noResponse
    case badResponse
    case invalidStatusCode
    case internalError(error: Error)
    
    public var errorDescription: String? {
        // TODO: Localization...
        switch self {
        case .badURL:
            return "The URL is invalid, please use a valid URL"
        case .noResponse:
            return "Can not find a response, please try again later"
        case .badResponse:
            return "Invalid Response, we can't parse the data"
        case .invalidStatusCode:
            return "Invalid server status, please try again later"
        case let .internalError(error):
            switch (error as NSError).code {
            case NSURLErrorNotConnectedToInternet:
                return "No connection to the internet, please check the connection and try again"
            case NSURLErrorTimedOut:
                return "The server taking too long time to fetch the data, please try again later"
            default:
                return error.localizedDescription
            }
        }

    }
    
    public var code: Int {
        switch self {
        case let .internalError(error):
            return (error as NSError).code
        default:
            return (self as NSError).code
        }
    }
    
    public var message: String {
        localizedDescription
    }
}

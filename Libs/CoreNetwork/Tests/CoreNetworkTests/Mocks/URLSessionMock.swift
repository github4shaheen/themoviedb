// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import CoreNetwork

class URLSessionMock: URLSessionProtocol {
    // Mock values
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    var isFetchDataTaskCalled = false
    
    func fetchData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.global().async { [self] in
            completionHandler(data, urlResponse, error)
        }
    }
    
    func fetchDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        isFetchDataTaskCalled = true
        DispatchQueue.global().async { [self] in
            completionHandler(data, urlResponse, error)
        }
        let request = URLRequest(url: url)
        return URLSession.shared.dataTask(with: request)
    }
}

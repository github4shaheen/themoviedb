// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public protocol URLSessionProtocol {
    func fetchData(with request: URLRequest, completionHandler:  @escaping (Data?, URLResponse?, Error?) -> Void)
    func fetchDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    public func fetchData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = self.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
    public func fetchDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = self.dataTask(with: url, completionHandler: completionHandler)
        task.resume()
        return task
    }
}

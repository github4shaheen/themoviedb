// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public protocol APIClientProtocol {
    var session: URLSessionProtocol { get }
    func request<T: Decodable>(with request: RequestProtocol, completion: @escaping (Result<T, APIClientErrors>) -> Void)
}

public extension APIClientProtocol {
    func request<T: Decodable>(with request: RequestProtocol, completion: @escaping (Result<T, APIClientErrors>) -> Void) {

        let completionOnMain: (Result<T, APIClientErrors>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let url = request.urlComponents?.url else {
            completion(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeoutInterval)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        session.fetchData(with: urlRequest) { data, response, error in
            if let error = error {
                completionOnMain(.failure(.internalError(error: error)))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(.noResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(.invalidStatusCode))
            }

            guard let data = data else { return }

            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(parsedData))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(.badResponse))
            }
        }
    }
}

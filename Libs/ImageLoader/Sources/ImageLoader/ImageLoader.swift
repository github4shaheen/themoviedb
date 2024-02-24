// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import CoreNetwork
import Cache

public class ImageLoader {
    
    public static let loader = ImageLoader()
    public var cache = Cache<UIImage>()

    var session: URLSessionProtocol
    
    private var runningRequests = [UIImageView: URLSessionDataTask]()
    
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func load(from urlString: String?, for imageView: UIImageView) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = nil
            return
        }
        
        load(url, for: imageView) { result in
            switch result {
            case let .success(image):
                imageView.image = image
            case let .failure(error):
                imageView.image = nil
                debugPrint(error)
            }
        }
    }
    
    public func load(_ url: URL, for imageView: UIImageView, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        let completionOnMain: (Result<UIImage, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        if let image = retrieveFromCacheBeforeDownload(with: url.absoluteString) {
            imageView.image = image
            return
        }
        
        let task = session.fetchDataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.cancel(for: imageView)
            }
            
            if let data = data, let image = UIImage(data: data) {
                self?.cache.save(image, forKey: url.absoluteString)
                completionOnMain(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completionOnMain(.failure(error))
                return
            }
        }
        
        runningRequests[imageView] = task
    }
    
    public func cancel(for imageView: UIImageView) {
        guard let task = runningRequests.removeValue(forKey: imageView) else {
            return
        }
        task.cancel()
    }
    
    private func retrieveFromCacheBeforeDownload(with url: String) -> UIImage? {
        cache.retrieve(from: url)
    }
}

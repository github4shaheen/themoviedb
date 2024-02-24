// The Swift Programming Language
// https://docs.swift.org/swift-book


import XCTest
import UIKit
import ImageLoader
import Cache

final class ImageLoaderTests: XCTestCase {
    
    var imageLoader: ImageLoader!
    var session: URLSessionMock!

    
    override func setUpWithError() throws {
        session = URLSessionMock()
        imageLoader = ImageLoader(session: session)
    }

    override func tearDownWithError() throws {
        session = nil
        imageLoader = nil
    }
    
    func testLoadImageWhenImageLoadingSucceeded() {
        // Given
        let urlString = "https://media.themoviedb.org/t/p/w600/mock.jpg"
        let imageData = UIImage.checkmark.pngData()
        let imageView = UIImageView()
        
        // When
        guard let url = URL(string: urlString) else {
            XCTFail("Can't create required test values")
            return
        }
        session.data = imageData
        var loadedImage: UIImage?
        imageLoader.load(url, for: imageView) { result in
            switch result {
            case .success(let image):
                loadedImage = image
            case .failure:
                XCTFail("should not fail")
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting image loaded successfully")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(loadedImage)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testLoadImageWhenImageLoadingFailed() {
        // Given
        let givenErrorCode = 400
        let urlString = "https://www.mock.com/u/1?v=4"
        let imageView = UIImageView()
        
        // When
        guard let url = URL(string: urlString) else {
            XCTFail("Can't create required test values")
            return
        }
        session.error = NSError(
            domain: "",
            code: givenErrorCode,
            userInfo: [:]
        )
        
        var errorCode: Int?
        imageLoader.load(url, for: imageView) { result in
            switch result {
            case .success:
                XCTFail("should not succeed")
            case .failure(let error):
                errorCode = (error as NSError).code
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting image loaded successfully")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorCode, givenErrorCode)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testLoadImageWhenImageIsCachedExpectingLoadImageNotCalled() {
        // Given
        let urlString = "https://media.themoviedb.org/t/p/w600/mock.jpg"
        let image = UIImage.checkmark
        let imageView = UIImageView()
        
        // When
        guard let url = URL(string: urlString) else {
            XCTFail("Can't create required test values")
            return
        }
        
        let cache = Cache<UIImage>()
        cache.save(image, forKey: urlString)
        imageLoader.cache = cache
        session.data = image.pngData()
        imageLoader.load(url, for: imageView) { result in
            switch result {
            case .success:
                XCTFail("should not succeed")
            case .failure:
                XCTFail("should not fail")
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting image loaded successfully")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(session.isFetchDataTaskCalled)
        } else {
            XCTFail("Timeout")
        }
    }

}

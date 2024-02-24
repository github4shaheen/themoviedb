// The Swift Programming Language
// https://docs.swift.org/swift-book


import XCTest
import CoreNetwork


final class APIClientTests: XCTestCase {
    var apiClientMock: APIClientMock!
    var urlSessionMock: URLSessionMock!
    
    override func setUpWithError() throws {
        apiClientMock = APIClientMock()
        urlSessionMock = URLSessionMock()
        apiClientMock.session = urlSessionMock
    }

    override func tearDownWithError() throws {
        apiClientMock = nil
        urlSessionMock = nil
    }
    
    func testRequestExpectingValidURL() {
        // Given
        let request = RequestMock()
        let baseURL = "https://www.baseURL.com"
        let path = "/path"
        let fullURL = baseURL + path
        
        // When
        request.baseURL = baseURL
        request.path = path
        
        // Then
        XCTAssertNotNil(request.urlComponents?.url)
        XCTAssertEqual(request.urlComponents?.url?.absoluteString, fullURL)
    }
    
    func testRequestExpectingBadURL() {
        // Given
        let request = RequestMock()
        let baseURL = "https://www.baseURL.com"
        let path = "\\/\\path"
        
        // When
        request.baseURL = baseURL
        request.path = path
        
        // Then
        XCTAssertNil(request.urlComponents?.url)
    }
    
    func testRequestForSuccessExpectingValidResponse() {
        // Given
        let request = RequestMock()
        
        // When
        var responseModel: ResponseModelMock?
        urlSessionMock.data = "{ \"key\": \"value\" }".data(using: .utf8)
        urlSessionMock.urlResponse = HTTPURLResponse()
        
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            switch result {
            case .success(let model):
                responseModel = model
            case .failure:
                XCTFail("should not fail")
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting valid response")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(responseModel)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testRequestResultBackInMainThread() {
        // Given
        let request = RequestMock()
        
        // When
        var isMainThread = false
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            isMainThread = Thread.isMainThread
        }
        
        // Then
        let exp = expectation(description: "Expecting result back in main thread")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(isMainThread)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testRequestWithBadURLExpectingBadURLError() {
        // Given
        let request = RequestMock()
        request.path = "invalid\\path/"
        
        // When
        var errorCode: Int?
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            switch result {
            case .success:
                XCTFail("should not succeed")
            case .failure(let error):
                errorCode = error.code
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting badURL error")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorCode, APIClientErrors.badURL.code)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testRequestForNoResponseExpectingNoResponseError() {
        // Given
        let request = RequestMock()
        
        // When
        var errorCode: Int?
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            switch result {
            case .success:
                XCTFail("should not succeed")
            case .failure(let error):
                errorCode = error.code
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting noResponse error")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorCode, APIClientErrors.noResponse.code)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testRequestForBadResponseExpectingBadResponseError() {
        // Given
        let request = RequestMock()
        
        // When
        var errorCode: Int?
        urlSessionMock.data = "{ iiiii \"value\" }".data(using: .utf8)
        urlSessionMock.urlResponse = HTTPURLResponse()
        
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            switch result {
            case .success:
                XCTFail("should not succeed")
            case .failure(let error):
                errorCode = error.code
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting badResponse error")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorCode, APIClientErrors.badResponse.code)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testRequestForInvalidStatusCodeExpectingInvalidStatusCodeError() {
        // Given
        let request = RequestMock()
        let statusCode = 400
        
        // When
        var errorCode: Int?
        guard let url = request.urlComponents?.url else {
            XCTFail("Can't get url")
            return
        }
        
        urlSessionMock.urlResponse = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: request.headers
        )
        
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            switch result {
            case .success:
                XCTFail("should not succeed")
            case .failure(let error):
                errorCode = error.code
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting invalidStatusCode error")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorCode, APIClientErrors.invalidStatusCode.code)
        } else {
            XCTFail("Timeout")
        }
    }
    
    func testRequestForInvalidStatusCodeExpectingInternalError() {
        // Given
        let request = RequestMock()
        let givenCode = -1009
        
        // When
        var errorCode: Int?
        urlSessionMock.error = NSError(
            domain: "",
            code: givenCode,
            userInfo: [:]
        )
        
        apiClientMock.request(with: request) { (result: Result<ResponseModelMock, APIClientErrors>) in
            switch result {
            case .success:
                XCTFail("should not succeeded")
            case .failure(let error):
                errorCode = error.code
            }
        }
        
        // Then
        let exp = expectation(description: "Expecting Internal error code")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorCode, givenCode)
        } else {
            XCTFail("Timeout")
        }
    }
}

// The Swift Programming Language
// https://docs.swift.org/swift-book


import XCTest
@testable import MovieDetails

final class MovieDetailsViewModelTests: XCTestCase {
    var repo: MovieDetailsRepoMock!
    var viewModel: MovieDetailsViewModel!
    
    override func setUpWithError() throws {
        let id = 1
        repo = MovieDetailsRepoMock()
        viewModel = MovieDetailsViewModel(id: id, repo: repo)
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
    }

    func testViewDidLoadExpectingFetchUserCalled() {
        // when
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(repo.fetchMovieCalled)
    }
    
    func testViewDidLoadExpectingUserFetched() {
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertNotNil(viewModel.getHeader())
    }
    
    func testViewDidLoadWhenFetchMovieFailedExpectedUserNotFetched() {

        // When
        repo.shouldFetchMovieSucceed = false
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertNil(viewModel.getHeader())
    }
    
    
    func testRetryExpectingMovieFetched() {
        
        // When
        viewModel.viewDidLoad()
        let header = viewModel.getHeader()
        
        // Then
        XCTAssertNotNil(header)
    }
    
    func testRetryExpectingFetchUserFailed() {
        // When
        repo.shouldFetchMovieSucceed = false
        viewModel.retry()
        let header = viewModel.getHeader()
        
        // Then
        XCTAssertNil(header)
    }
}

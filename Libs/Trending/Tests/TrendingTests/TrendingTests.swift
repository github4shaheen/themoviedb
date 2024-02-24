import XCTest

import XCTest
@testable import Trending

final class TrendingViewModelTests: XCTestCase {
    var repo: TrendingRepoMock!
    var viewModel: TrendingViewModel!
    
    override func setUpWithError() throws {
        repo = TrendingRepoMock()
        viewModel = TrendingViewModel(repo: repo, delegate: nil)
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
    }

    func testViewDidLoadExpectingFetchUsersCalled() {
        // when
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(repo.fetchMovieCalled)
    }
    
    func testViewDidLoadExpectingFirstPageFetched() {
        // Given
        let expectedNumberOfItems = 20
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.numberOfItems, expectedNumberOfItems)
    }
    
    func testViewDidLoadWhenFetchUserFailedExpextedNoUsersFetched() {
        // Given
        let expectedNumberOfItems = 0
        
        // When
        repo.shouldFetchMoviesSucceed = false
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.numberOfItems, expectedNumberOfItems)
    }
    
    func testItemWillDisplayExpectingNextPageFetched() {
        // Given
        let indexPath = IndexPath(item: 19, section: 0)
        let expectedNumberOfItems = 40
        
        // When
        viewModel.viewDidLoad()
        viewModel.viewWillDisplayItem(at: indexPath)
        
        // Then
        XCTAssertEqual(viewModel.numberOfItems, expectedNumberOfItems)
    }
    
    func testItemWillDisplayExpectingStillInTheSamePage() {
        // Given
        let indexPath = IndexPath(item: 5, section: 0)
        let expectedNumberOfItems = 20
        
        // When
        viewModel.viewDidLoad()
        viewModel.viewWillDisplayItem(at: indexPath)
        
        // Then
        XCTAssertEqual(viewModel.numberOfItems, expectedNumberOfItems)
    }
    
    func testGetMovieItemExpectingMovieFound() {
        // Given
        let indexPath = IndexPath(item: 15, section: 0)
        
        // When
        
        viewModel.viewDidLoad()
        let movie = viewModel.getItem(for: indexPath)
                
        // Then
        let expectation =  expectation(description: "wait to fetch movies")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation] ,timeout: 5)
        
        XCTAssertNotNil(movie)
    }
    
    func testGetMovieItemExpectingUserNotFound() {
        // Given
        let indexPath = IndexPath(item: 25, section: 0)
        
        // When
        viewModel.viewDidLoad()
        let movie = viewModel.getItem(for: indexPath)
        
        // Then
        let expectation =  expectation(description: "wait to fetch movies")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation] ,timeout: 5)

        XCTAssertNil(movie)
    }
    
    func testRetryExpextingFirstPageFetched() {
        // Given
        let expectedNumberOfItems = 20
        
        // When
        viewModel.retry()
        
        // Then
        XCTAssertEqual(viewModel.numberOfItems, expectedNumberOfItems)
    }
    
    func testRetryExpextingFetchUsersFailed() {
        // Given
        let expectedNumberOfItems = 0
        
        // When
        repo.shouldFetchMoviesSucceed = false
        viewModel.retry()
        
        // Then
        XCTAssertEqual(viewModel.numberOfItems, expectedNumberOfItems)
    }
}

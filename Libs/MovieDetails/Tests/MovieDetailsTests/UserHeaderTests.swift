// The Swift Programming Language
// https://docs.swift.org/swift-book


import XCTest
@testable import MovieDetails

final class UserHeaderTests: XCTestCase {
    func testMovieDetailsHeaderInit() {
        // When
        let movieHeader = MovieDetailsMockGenerator.movieHeader
        

        // Then
        XCTAssertEqual(movieHeader.id, 1)
        XCTAssertEqual(movieHeader.poster, "simple.png")
        XCTAssertEqual(movieHeader.title, "mojombo")
        XCTAssertEqual(movieHeader.overview, "Movie Overview")

    }

}

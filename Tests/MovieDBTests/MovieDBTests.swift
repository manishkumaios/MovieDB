import XCTest
@testable import MovieDB

final class MovieDBTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MovieDB().text, "Hello, World!")
    }
}

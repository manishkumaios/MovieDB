import XCTest
@testable import MovieDB


class MovieListViewModelTests: XCTestCase {
    let viewModel = MovieListViewModel.init(dataManager: MockDataManager())
    func testScreenTitle() {
        XCTAssertEqual(viewModel.screenTitle, "popular movies")
    }
    
    func testNumberOfRowsWithoutApiLoad() {
        XCTAssertEqual(viewModel.numberOfRows, 0)
    }
    
    func testNumberOfRowsWithApiLoad() {
        viewModel.fetchPopularMovies()
        XCTAssertEqual(self.viewModel.numberOfRows, 20)
        
    }
}

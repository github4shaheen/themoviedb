// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import TMDBSchemeModels
import TMDBRepo
import UIModels

class TrendingViewModel {
    // MARK: - Constants
    private var page = 0
    private var totalPages = 0

    
    // MARK: - Properties
    private var movies: [Movie] = []
    private let repo: TrendingRepoProtocol
    weak var delegate: TrendingViewDelegate?
    
    private var state: ViewContentState = .started {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var isLoadingPage: Bool { state == .loading }
    var numberOfItems: Int { return movies.count }
    
        
    // MARK: - Inits
    init(repo: TrendingRepoProtocol, delegate: TrendingViewDelegate? = nil) {
        self.repo = repo
        self.delegate = delegate
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        fetchTrendingMovies()
    }
    
    private func fetchTrendingMovies() {
        guard isLoadingPage == false else { return }
        state = .loading
        repo.fetchTrendingMovies(page: self.page + 1) { [weak self] result in
            switch result {
            case let .success(response):
                self?.handleFetchTrendingMovies(with: response)
            case .failure(let error):
                self?.handleError(with: error.errorDescription)
            }
        }
    }
    
    private func handleFetchTrendingMovies(with response: TrendingResponse) {
        if response.totalResults == 0 {
            // TODO: - Localization...
            state = .error(
                text: "No movies found",
                description: "we couldn't fetch you any movies, please try again later",
                actionTitle: "Retry"
            )
            return
        }
        self.page = response.page
        self.totalPages = response.totalPages
        didLoadNewPage(of: response.results)
        state = .populated
    }
    
    private func handleError(with errorDescription: String?) {
        // TODO: - Localization...
        state = .error(
            text: "Opps something went wrong",
            description: errorDescription,
            actionTitle: "Retry"
        )
    }
    
    private func didLoadNewPage(of movies: [Movie]) {
        let lastIndex = self.movies.count
        let newLastIndex = lastIndex + movies.count - 1
        let newIndexPaths: [IndexPath] = Array(lastIndex ... newLastIndex).map{IndexPath(item: $0, section: 0)}
        self.movies.append(contentsOf: movies)
        delegate?.reload(indexPaths: newIndexPaths)
    }
    
    func getItem(for indexPath: IndexPath) -> Movie? {
        guard indexPath.row < movies.count else { return nil }
        return movies[indexPath.row]
    }
    
    func didSelectItem(with indexPath: IndexPath) {
        guard let movie = getItem(for: indexPath) else { return }
        delegate?.navigateToMovieDetailsView(with: movie.id)
    }
    
    func viewWillDisplayItem(at indexPath: IndexPath) {
        guard shouldLoadNextPage(indexPath: indexPath) else { return }
        fetchTrendingMovies()
    }
    
    private func shouldLoadNextPage(indexPath: IndexPath) -> Bool {
        didReachLastItems(indexPath: indexPath) && isLoadingPage == false && self.page != self.totalPages
    }
    
    private func didReachLastItems(indexPath: IndexPath) -> Bool {
        return movies.count - 1  == indexPath.row
    }
    
    func retry() {
        fetchTrendingMovies()
    }
}

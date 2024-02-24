// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIModels
import TMDBRepo
import TMDBSchemeModels

class MovieDetailsViewModel {
    // MARK: - Properties
    private var id: Int
    private var movieHeader: MovieHeader?
    
    private let repo: MovieDetailsRepoProtocol
    
    weak var delegate: ViewContentStateDelegate?
    
    private var state: ViewContentState = .started {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    
    // MARK: - Inits
    init(id: Int, repo: MovieDetailsRepoProtocol) {
        self.id = id
        self.repo = repo
    }
    
    func viewDidLoad() {
        fetchGitHubUserProfile()
    }
    
    // MARK: - Methods
    private func fetchGitHubUserProfile() {
        state = .loading
        repo.fetchMovieDetails(with: "\(id)") { [weak self] result in
            switch result {
            case let .success(movie):
                self?.handleFetchGitHubUserProfileSuccess(with: movie)
            case .failure(let error):
                self?.handleError(with: error.errorDescription)
            }
        }
    }
    
    private func handleFetchGitHubUserProfileSuccess(with movie: MovieDetails) {
        movieHeader = movie.head()
        state = .populated
    }
    
    private func handleError(with errorDescription: String?) {
        state = .error(
            text: "Opps something went wrong",
            description: errorDescription,
            actionTitle: "Retry"
        )
    }
    
    func getHeader() -> MovieHeader? {
        return movieHeader
    }
        
    func retry() {
        fetchGitHubUserProfile()
    }
}

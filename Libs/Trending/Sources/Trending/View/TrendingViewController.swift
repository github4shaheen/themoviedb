// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import UIModels
import UIErrorView
import MovieDetails

class TrendingViewController: UIViewController {
    // MARK: - Constants
    private let estimateRowHight = 64.0
    private let listFooterViewHight = 30.0
    private let cellFadeDuration: TimeInterval = 0.2
    private let navigationTitle = "Trending Movies"
    
    // MARK: - Views
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = estimateRowHight
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var errorView: UIErrorView? = {
        let errorView = UIErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    } ()
    
    // MARK: - View model
    private var viewModel: TrendingViewModel
    
    // MARK: - Inits
    public init(viewModel: TrendingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Methods
    private func setupLayout() {
        view.backgroundColor = .white
        //TODO: localization
        title = navigationTitle
        
        // Add moviesTableView to view
        view.embed(view: moviesTableView)
        setTableViewFooter()
    }
    
    private func setTableViewFooter() {
        let footerView = TrendingFooterView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: listFooterViewHight))
        moviesTableView.tableFooterView = footerView
    }
    
    private func startFooterActivityIndicator() {
        let footerView = moviesTableView.tableFooterView as? TrendingFooterView
        footerView?.startLoading()
    }
    
    private func stopFooterActivityIndicator() {
        let footerView = moviesTableView.tableFooterView as? TrendingFooterView
        footerView?.stopLoading()
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate and DataSource
    // TODO: - Create TableViewDataSource for table dataSource
    // TODO: - Create TableViewPHandler for table Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self)) as? MovieTableViewCell
        let item = viewModel.getItem(for: indexPath)
        cell?.setup(with: item)
        cell?.alpha = 0
        let animator = UIViewPropertyAnimator(duration: cellFadeDuration, curve: .easeIn) {
            cell?.alpha = 1
        }
        animator.startAnimation()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.viewWillDisplayItem(at: indexPath)
    }
}

extension TrendingViewController: TrendingViewDelegate {
    // MARK: - List View Delegate
    func navigateToMovieDetailsView(with id: Int) {
        let movieDetailsView = MovieDetailsRouter.assemble(id: id)
        navigationController?.pushViewController(movieDetailsView, animated: true)
    }
    
    func reload(indexPaths: [IndexPath]) {
        moviesTableView.insertRows(at: indexPaths, with: .none)
        moviesTableView.reloadRows(at: indexPaths, with: .none)
    }
    
    func didUpdate(with state: ViewContentState) {
        removeErrorView()
        stopFooterActivityIndicator()
        moviesTableView.isHidden = false
        switch state {
        case .started, .populated:
            break
        case .loading:
            startFooterActivityIndicator()
        case let .error(text, description, actionTitle):
            moviesTableView.isHidden = true
            addErrorView(with: UIImage.checkmark, errorText: text, errorDescription: description, actionTitle: actionTitle)
        }
    }
}

extension TrendingViewController: UIErrorViewDelegate {
    // MARK: - Error view delegate
    func retryButtonDidPressed() {
        viewModel.retry()
    }
}

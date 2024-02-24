// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import UIErrorView
import UIModels

class MovieDetailsViewController: UIViewController {
    // MARK: - Constants
    private let headerViewHight = 132.0
    private let defaultReuseIdentifier = "Cell"
    
    // MARK: - Views
    private lazy var userProfileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    } ()
    
    var errorView: UIErrorView? = {
        let errorView = UIErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    } ()
    
    // MARK: - View model
    private var viewModel: MovieDetailsViewModel
    
    // MARK: - Inits
    init(viewModel: MovieDetailsViewModel) {
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
        
        // Add userProfileTableView to view
        view.embed(view: userProfileTableView)
        
        // Add activity Indicator to view
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            view.createConstraint(attribute: .centerX, toItem: activityIndicatorView, attribute: .centerX),
            view.createConstraint(attribute: .centerY, toItem: activityIndicatorView, attribute: .centerY)
        ])
    }

    private func setTableViewHeader(with header: MovieHeader?) {
        let headerView = MovieHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: headerViewHight))
        headerView.setup(with: header)
        userProfileTableView.tableHeaderView = headerView
    }
    
    private func startActivityIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
}


extension MovieDetailsViewController: ViewContentStateDelegate {
    // MARK: - Loading state delegate
    func didUpdate(with state: ViewContentState) {
        stopActivityIndicator()
        removeErrorView()
        switch state {
        case .started:
            break
        case .loading:
            startActivityIndicator()
        case .populated:
            setTableViewHeader(with: viewModel.getHeader())
            userProfileTableView.reloadData()
        case let .error(text, description, actionTitle):
            addErrorView(with: UIImage.checkmark, errorText: text, errorDescription: description, actionTitle: actionTitle)
        }
    }
}

extension MovieDetailsViewController: UIErrorViewDelegate {
    // MARK: - Error view delegate
    func retryButtonDidPressed() {
        viewModel.retry()
    }
}

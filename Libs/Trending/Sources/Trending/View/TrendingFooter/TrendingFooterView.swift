// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit

class TrendingFooterView: UIView {
    // MARK: - Constants
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    } ()
    
    // MARK: - Inits
    init() {
        super.init(frame: CGRectZero)
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout
    private func setupLayout() {
        // Add activityIndicatorView
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            createConstraint(attribute: .centerX, toItem: activityIndicatorView, attribute: .centerX),
            createConstraint(attribute: .centerY, toItem: activityIndicatorView, attribute: .centerY)
        ])
    }
    
    // MARK: - ActivityIndicator
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
}

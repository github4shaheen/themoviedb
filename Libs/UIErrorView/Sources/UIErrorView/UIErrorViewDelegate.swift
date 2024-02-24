// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import UIKitExtensions

public protocol UIErrorViewDelegate: AnyObject {
    var errorView: UIErrorView? { get set }
    func addErrorView(with errorImage: UIImage?, errorText: String, errorDescription: String?, actionTitle: String?)
    func removeErrorView()
    func retryButtonDidPressed()
}

public extension UIErrorViewDelegate where Self: UIViewController {
    
    func addErrorView(with errorImage: UIImage?, errorText: String, errorDescription: String?, actionTitle: String?) {
        errorView?.removeFromSuperview()
        guard let errorView = errorView else { return }
        errorView.delegate = self
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.createConstraint(attribute: .leading, toItem: errorView, attribute: .leading),
            view.createConstraint(attribute: .trailing, toItem: errorView, attribute: .trailing),
            view.createConstraint(attribute: .centerY, toItem: errorView, attribute: .centerY)
        ])
        errorView.setupView(with: errorImage, errorText: errorText, errorDescription: errorDescription)
    }
    
    func removeErrorView() {
        errorView?.removeFromSuperview()
    }
    
    func retryButtonDidPressed() {}
}

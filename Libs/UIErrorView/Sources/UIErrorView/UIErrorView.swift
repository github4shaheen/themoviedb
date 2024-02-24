// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import UIKitExtensions

public class UIErrorView: UIView {
    // MARK: - Constans
    private let contentStakViewSpacing = 16.0
    private let contentStakViewXMargin = 32.0
    private let errorImageViewSide = 112.0
    private let actionButtonWidth = 128.0
    private let actionButtonHeight = 32.0
    private let fontSize = 16.0
    
    //MARK: - Views
    private lazy var contentStakView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = contentStakViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    // MARK: - Delegate
    weak var delegate: UIErrorViewDelegate?

    // MARK: - Init
    public init() {
        super.init(frame: CGRectZero)
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupLayout
    private func setupLayout() {
        // Add Content StackVieew
        embed(view: contentStakView, leading: contentStakViewXMargin, trailing: -contentStakViewXMargin)
        
        // Add errorImageView
        contentStakView.addArrangedSubview(errorImageView)
        NSLayoutConstraint.activate([
            errorImageView.widthAnchor.constraint(equalToConstant: errorImageViewSide),
            errorImageView.heightAnchor.constraint(equalToConstant: errorImageViewSide)
        ])
        
        // Add textLabel
        contentStakView.addArrangedSubview(textLabel)
        
        // Add descriptionLabel
        contentStakView.addArrangedSubview(descriptionLabel)
        
        // Add retryButton
        contentStakView.addArrangedSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalToConstant: actionButtonWidth),
            actionButton.heightAnchor.constraint(equalToConstant: actionButtonHeight)
        ])
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        actionButton.addTarget(self, action:  #selector(retryButtonDidPressed), for: .touchUpInside)
    }
    
    @objc private func retryButtonDidPressed(_ sender: Any) {
        delegate?.retryButtonDidPressed()
    }
}

public extension UIErrorView {
    // MARK: - Setup View
    func setupView(
        with errorImage: UIImage? = UIImage(named: "github_eyes"),
        errorText: String,
        errorDescription: String? =  nil,
        actionTitle: String? = "Retry"
    ) {
        errorImageView.image = errorImage
        textLabel.text = errorText
        descriptionLabel.text = errorDescription
        actionButton.setTitle(actionTitle, for: .normal)
    }
}

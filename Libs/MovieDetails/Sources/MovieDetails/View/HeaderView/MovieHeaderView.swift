// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import TMDBSchemeModels


class MovieHeaderView: UIView {
    // MARK: - Constants
    private let contentStackViewSpacing = 8.0
    private let contentStackViewXMargin = 16.0
    private let contentStackViewYMargin = 8.0
    private let posterImageViewHeight = 150.0
    private let aspectRatioWH: CGFloat = 1/1.5
    
    //MARK: - Views
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseYearLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


        
    // MARK: - Inits
    init() {
        super.init(frame: CGRectZero)
        setupLayout()
    }
    
    // MARK: DeInit
    deinit {
        posterImageView.cancelImageLoad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func setupLayout() {
        
        addSubview(posterImageView)
        addSubview(titleLbl)
        addSubview(releaseYearLbl)
        addSubview(overviewLbl)
        
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: CGFloat(posterImageViewHeight)),
            posterImageView.widthAnchor.constraint(equalToConstant: CGFloat(posterImageViewHeight) * aspectRatioWH),
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: contentStackViewYMargin),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -contentStackViewYMargin),
            posterImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: contentStackViewYMargin),
            posterImageView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: contentStackViewYMargin)
            ])
                        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: contentStackViewYMargin * 4),
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentStackViewXMargin),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentStackViewXMargin),
            ])
        
        NSLayoutConstraint.activate([
            releaseYearLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: contentStackViewYMargin),
            releaseYearLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentStackViewXMargin),
            releaseYearLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentStackViewXMargin)
            ])
        
        NSLayoutConstraint.activate([
            overviewLbl.topAnchor.constraint(equalTo: releaseYearLbl.bottomAnchor, constant: contentStackViewYMargin * 2),
            overviewLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentStackViewXMargin),
            overviewLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentStackViewXMargin),
            overviewLbl.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -contentStackViewXMargin)
            ])
    }

}

extension MovieHeaderView {
    // MARK: - Setup View
    func setup(with movie: MovieHeader?) {
        posterImageView.loadImage(with: movie?.poster)
        titleLbl.text = movie?.title
        releaseYearLbl.text = movie?.releaseYear
        overviewLbl.text = movie?.overview
        
    }
}

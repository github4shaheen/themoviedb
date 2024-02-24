// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit
import TMDBSchemeModels

class MovieTableViewCell: UITableViewCell {
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

        
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageLoad()
        posterImageView.image = nil
        titleLbl.text = nil
        releaseYearLbl.text = nil
    }
    
    // MARK: - Methods
    private func setupLayout() {
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(releaseYearLbl)
        
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: CGFloat(posterImageViewHeight)),
            posterImageView.widthAnchor.constraint(equalToConstant: CGFloat(posterImageViewHeight) * aspectRatioWH),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentStackViewYMargin),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentStackViewYMargin),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentStackViewYMargin)
            ])
                        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentStackViewYMargin),
            titleLbl.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: contentStackViewXMargin),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentStackViewXMargin),
            ])
        
        NSLayoutConstraint.activate([
            releaseYearLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: contentStackViewYMargin),
            releaseYearLbl.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: contentStackViewXMargin),
            releaseYearLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentStackViewXMargin)
            ])
    }

}

extension MovieTableViewCell {
    // MARK: - Setup View
    func setup(with movie: Movie?) {
        posterImageView.loadImage(with: movie?.poster)
        titleLbl.text = movie?.title
        releaseYearLbl.text = movie?.releaseYear
        
    }
}

//
//  DetailViewController.swift
//  TheMovieDB
//
//  Created by Fede Flores on 14/03/2024.
//

import UIKit

protocol DetailViewProtocols: AnyObject {}

class DetailViewController: UIViewController, DetailViewProtocols {
    
    fileprivate enum Constant {
        static let contentViewCornerRadius: CGFloat = 12
        static let summaryLabelFontSize: CGFloat = 22
        static let titleLabelNumberOfLines: Int = 0
        static let titleLabelFontSize: CGFloat = 30
        static let overviewLabelFontSize: CGFloat = 22
        static let descriptionLabelNumberOfLines: Int = 0
        static let descriptionLabelFontSize: CGFloat = 16
        static let heartIcon: String = "heart"
        static let heartIconFilled: String = "heart.fill"
        static let releaseDateLabelFontSize: CGFloat = 26
        static let movieImageViewHeight: CGFloat = 320
        static let contentViewTopAnchor: CGFloat = 10
        static let circleRatingViewTopAnchor: CGFloat = 8
        static let circleRatingViewSize: CGFloat = 50
        static let summaryLabelTopAnchor: CGFloat = 24
        static let summaryLabelHorizontalPadding: CGFloat = 12
        static let favoriteButtonTrailingAnchor: CGFloat = 8
        static let favoriteButtonSize: CGFloat = 30
        static let titleLabelTopAnchor: CGFloat = 12
        static let overviewLabelTopAnchor: CGFloat = 24
        static let descriptionLabelTopAnchor: CGFloat = 12
        static let releaseDateLabelTopAnchor: CGFloat = 24
    }
    
    fileprivate enum Wording {
        static let summaryLabelText: String = "Summary"
        static let overviewLabelText: String = "Overview"
        static let releaseDateLabelText: String = "Release: "
    }
    
    var presenter: DetailPresenterProtocols?
    let viewModel: DetailMovieViewModel
    
    private var isFavorite: Bool = false
    
    init(viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = Constant.contentViewCornerRadius
        view.backgroundColor = TMDBColor.main700.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Wording.summaryLabelText
        label.textColor = TMDBColor.main900.color
        label.font = .boldSystemFont(ofSize: Constant.summaryLabelFontSize)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Constant.titleLabelNumberOfLines
        label.textColor = TMDBColor.main00.color
        label.font = .boldSystemFont(ofSize: Constant.titleLabelFontSize)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Wording.overviewLabelText
        label.textColor = TMDBColor.main900.color
        label.font = .boldSystemFont(ofSize: Constant.overviewLabelFontSize)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Constant.descriptionLabelNumberOfLines
        label.textColor = TMDBColor.main00.color
        label.font = .systemFont(ofSize: Constant.descriptionLabelFontSize)
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = TMDBColor.main900.color
        button.setImage(UIImage(systemName: Constant.heartIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = TMDBColor.main900.color
        label.font = .boldSystemFont(ofSize: Constant.releaseDateLabelFontSize)
        return label
    }()
    
    private var circleRatingView: CircleRatingView = {
        let view = CircleRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpData()
    }
    
    private func setUpData() {
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.overview
        
        let imageURL = (Constants.imageBaseUrl + viewModel.posterPath)
        movieImageView.load(urlString: imageURL)
        circleRatingView.rating = viewModel.rating
        
        releaseDateLabel.text = Wording.releaseDateLabelText + viewModel.releaseDate        
    }
    
    
    private func setupViews() {
        view.backgroundColor = TMDBColor.main700.color
        view.addSubview(movieImageView)
        view.addSubview(contentView)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(circleRatingView)
        
        //movieImageView
        
        movieImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: Constant.movieImageViewHeight).isActive = true
        
        
        //contentView
        
        contentView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -Constant.contentViewTopAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //circleRatingView
        
        circleRatingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleRatingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.circleRatingViewTopAnchor).isActive = true
        circleRatingView.heightAnchor.constraint(equalToConstant: Constant.circleRatingViewSize).isActive = true
        circleRatingView.widthAnchor.constraint(equalToConstant: Constant.circleRatingViewSize).isActive = true
        
        //summaryLabel
        
        summaryLabel.topAnchor.constraint(equalTo: circleRatingView.bottomAnchor, constant: Constant.summaryLabelTopAnchor).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.summaryLabelHorizontalPadding).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.summaryLabelHorizontalPadding).isActive = true
        summaryLabel.setContentHuggingPriority(.required, for: .vertical)
        
        //favoriteButton
        
        favoriteButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        favoriteButton.centerYAnchor.constraint(equalTo: summaryLabel.centerYAnchor).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.favoriteButtonTrailingAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: Constant.favoriteButtonSize).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: Constant.favoriteButtonSize).isActive = true
        
        //titleLabel
        
        titleLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: Constant.titleLabelTopAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor).isActive = true
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        //overviewLabel
        
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.overviewLabelTopAnchor).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        overviewLabel.setContentHuggingPriority(.required, for: .vertical)
        
        //descriptionLabel
        
        descriptionLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: Constant.descriptionLabelTopAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: overviewLabel.trailingAnchor).isActive = true
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        
        //releaseDateLabel
        
        releaseDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constant.releaseDateLabelTopAnchor).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true
        releaseDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        
    }
    
    @objc private func buttonTapped() {
        isFavorite.toggle()
        favoriteButton.setImage(UIImage(systemName: isFavorite ? Constant.heartIconFilled :  Constant.heartIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
        presenter?.showAlert()
    }
    
}


#Preview("DetailViewController", traits: .defaultLayout, body: {
    DetailViewController(viewModel: DetailMovieViewModel(title: "The Godfather Part II", posterPath: "/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg", releaseDate: "1974-12-20", overview: "In the continuing saga of the Corleone crime family, a young Vito Corleone grows up in Sicily and in 1910s New York. In the 1950s, Michael Corleone attempts to expand the family business into Las Vegas, Hollywood and Cuba.", rating: 69.864))
})



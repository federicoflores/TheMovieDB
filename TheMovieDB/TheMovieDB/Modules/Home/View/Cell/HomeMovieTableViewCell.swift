//
//  HomeMovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import UIKit

class HomeMovieTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let movieImageViewTopPadding: CGFloat = 12
        static let titleLabelTopPadding: CGFloat = 12
        static let releaseDateLabel: CGFloat = 8
        static let releaseDateLabelBottomPadding: CGFloat = 18
        static let titleLabelFontSize: CGFloat = 28
        static let titleLabelNumberOfLines: Int = 2
        static let titleLabelLeading: CGFloat = 18
        static let releaseDateLabelFontSize: CGFloat = 18
        static let titleLabelMinimumScaleFactor: CGFloat = 0.8
    }
    
    fileprivate let movieImageView: UIImageView = UIImageView()
    fileprivate let titleLabel: UILabel = UILabel()
    fileprivate let releaseDateLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        
        contentView.backgroundColor = TMDBColor.main800.color
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //titleLabel
        
        titleLabel.textColor = TMDBColor.main00.color
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: Constant.titleLabelFontSize)
        titleLabel.numberOfLines = Constant.titleLabelNumberOfLines
        titleLabel.minimumScaleFactor = Constant.titleLabelMinimumScaleFactor
        
        titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constant.titleLabelTopPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.titleLabelLeading).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        //movieImageView
        
        movieImageView.contentMode = .scaleAspectFit
        
        movieImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.movieImageViewTopPadding).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        //releaseDateLabel
        
        releaseDateLabel.textColor = TMDBColor.main00.color
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.font = .italicSystemFont(ofSize: Constant.releaseDateLabelFontSize)
        
        releaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: Constant.releaseDateLabel).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        releaseDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.releaseDateLabelBottomPadding).isActive = true
    }
    
    func bind(viewModel: HomeMovieViewModel?) {
        guard let viewModel = viewModel else { return }
        let imageURL = (Constants.imageBaseUrl + viewModel.posterPath)
        movieImageView.downloaded(from: imageURL)
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
    }
}

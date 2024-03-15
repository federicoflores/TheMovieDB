//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Fede Flores on 12/03/2024.
//

import UIKit

protocol HomeViewProtocols: AnyObject {
    func reloadTableView()
    func showLoadingView()
    func hideLoadingView()
    func isEmptyStateHidden(isHidden: Bool)
    func setEmptyStateSubtitle(subtitle: String)
}

class HomeViewController: UIViewController {
    
    
    fileprivate enum Constant {
        static let titleLabelFont: CGFloat = 38
        static let tableViewTopAnchor: CGFloat = 32
        static let tableViewPaddingMultiplier: CGFloat = 0.1
        static let titleLabelCornerRadius: CGFloat = 12
        static let tableViewHorizontalPadding: CGFloat = 36
        static let cellCornerRadius: CGFloat = 16
        static let cellHeight: CGFloat = 400
        static let cellBorderWidth: CGFloat = 2
    }
    
    fileprivate enum Wording {
        static let titleLabelText: String = "Top Rated"
    }
    
    var homePresenter: HomePresenterProtocols?
    
    fileprivate let tableView: UITableView = UITableView()
    fileprivate let titleLabel: UILabel = UILabel()
    
    private let emptyStateView = EmptyStateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TMDBColor.main700.color
        setupViews()
        setupTableView()
        homePresenter?.fetchTopRatedMovies()
    }
    
    fileprivate func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        
        //Title Label
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * Constant.tableViewPaddingMultiplier / 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width * Constant.tableViewPaddingMultiplier / 2).isActive = true
        
        titleLabel.text = Wording.titleLabelText
        titleLabel.font = .boldSystemFont(ofSize: Constant.titleLabelFont)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = TMDBColor.main800.color
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = Constant.titleLabelCornerRadius
        
        //TableView
        
        tableView.backgroundColor = TMDBColor.main700.color
        
        
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.tableViewTopAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constant.tableViewHorizontalPadding).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.tableViewHorizontalPadding).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //EmptyStateView
        
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyStateView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        emptyStateView.action = homePresenter?.fetchTopRatedMovies
        emptyStateView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeMovieTableViewCell.self, forCellReuseIdentifier: String(describing: HomeMovieTableViewCell.self))
    }
    
}

extension HomeViewController: HomeViewProtocols {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func isEmptyStateHidden(isHidden: Bool) {
        emptyStateView.isHidden = isHidden
    }
    
    func setEmptyStateSubtitle(subtitle: String) {
        emptyStateView.subtitle = subtitle
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homePresenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeMovieTableViewCell.self), for: indexPath) as? HomeMovieTableViewCell else { return UITableViewCell() }
        cell.bind(viewModel: homePresenter?.getTopRatedMovieViewModel(from: indexPath.row))
        cell.clipsToBounds = true
        cell.layer.cornerRadius = Constant.cellCornerRadius
        cell.layer.borderColor = TMDBColor.main00.color.cgColor
        cell.layer.borderWidth = Constant.cellBorderWidth
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homePresenter?.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let didScrollToBottom = homePresenter?.didScrollToBottom(row: indexPath.row), didScrollToBottom {
            homePresenter?.fetchTopRatedMovies()
        }
    }
    
}




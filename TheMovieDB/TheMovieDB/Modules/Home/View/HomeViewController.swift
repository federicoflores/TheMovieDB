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
}

class HomeViewController: UIViewController {
    
    fileprivate enum Constant {
        static let titleLabelFont: CGFloat = 30
        static let tableViewTopAnchor: CGFloat = 32
        static let tableViewPaddingMultiplier: CGFloat = 0.1
    }
    
    var homePresenter: HomePresenterProtocols?
    
    
    fileprivate let tableView: UITableView = UITableView()
    fileprivate let titleLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TMDBColor.main500.color
        setupViews()
        setupTableView()
        homePresenter?.fetchTopRatedMovies()
        
    }
    
    fileprivate func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        //Title Label
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * Constant.tableViewPaddingMultiplier / 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width * Constant.tableViewPaddingMultiplier / 2).isActive = true
        
        titleLabel.text = "Top Rated"
        titleLabel.font = .boldSystemFont(ofSize: Constant.titleLabelFont)
        titleLabel.textColor = UIColor.white
        
        //TableView
        
        tableView.backgroundColor = TMDBColor.main700.color
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.tableViewTopAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homePresenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeMovieTableViewCell.self), for: indexPath) as? HomeMovieTableViewCell else { return UITableViewCell() }
        cell.bind(viewModel: homePresenter?.getTopRatedMovieViewModel(from: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homePresenter?.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }

}


var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
  func load(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
      self.image = image
      return
    }
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            imageCache.setObject(image, forKey: urlString as NSString)
            self?.image = image
          }
        }
      }
    }
  }
}

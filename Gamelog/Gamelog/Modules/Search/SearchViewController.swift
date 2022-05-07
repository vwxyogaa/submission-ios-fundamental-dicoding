//
//  SearchViewController.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
  var listGames: [ResultRawg]?
  
  // MARK: - Views
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.separatorStyle = .none
    tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    searchController.searchBar.tintColor = .black
    searchController.searchBar.barStyle = .default
    return searchController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTableView()
    setupSearchController()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    title = "Search"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .white
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    tableView.register(FreeGamesTableViewCell.self, forCellReuseIdentifier: "freeGamesCellId")
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func setupSearchController() {
    navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
  }
  
  private func search(_ query: String) {
    RawgProvider.shared.getSearch(query) { result in
      switch result {
      case .success(let games):
        self.listGames = games
        self.tableView.reloadData()
      case .failure(let error):
        let alert = UIAlertController(
          title: "Oops! Something went wrong",
          message: "\(error.localizedDescription)",
          preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Try Again", style: .default) { _ in
          self.search(query)
        })
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    search(searchBar.text ?? "")
  }
  
  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let string = NSString(string: searchBar.text ?? "").replacingCharacters(in: range, with: text)
    if string.count >= 1 {
      search(string)
    }
    return true
  }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listGames?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: "freeGamesCellId",
      for: indexPath
    ) as? FreeGamesTableViewCell {
      if let result = listGames?[indexPath.row] {
        let urlImage = result.backgroundImage
        cell.loadingView.startAnimating()
        cell.thumbImageView.kf.setImage(with: URL(string: urlImage)) { _ in
          cell.loadingView.stopAnimating()
        }
        cell.nameLabel.text = result.name
        cell.releaseLabel.text = result.released.string(format: "MMM dd, yyyy")
        let rating = result.rating
        let genre = result.genres?.last?.name
        cell.subtitleLabel.text = "\(rating) • \(genre ?? "")"
      }
      return cell
    } else {
      return UITableViewCell()
    }
  }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let viewController = DetailViewController()
    viewController.id = Int(listGames?[indexPath.row].id ?? 0)
    viewController.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if listGames != nil {
      let view = UIView(frame: .zero)
      let label = UILabel(frame: .zero)
      label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      label.textColor = .black
      label.text = "Search Result"
      view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
        label.topAnchor.constraint(equalTo: view.topAnchor),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      return view
    } else {
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0001
  }
}

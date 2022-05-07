//
//  HomeViewController.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
  var trendingContent: [ResultRawg]?
  
  // MARK: - Views
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.separatorStyle = .none
    tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .large
    return activityIndicator
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTableView()
    setupActivityIndicator()
    loadTrendingGames()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    title = "Gamelog"
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
    tableView.register(WelcomeTableViewCell.self, forCellReuseIdentifier: "welcomeCellId")
    tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: "trendingCellId")
    tableView.register(FreeGamesTableViewCell.self, forCellReuseIdentifier: "freeGamesCellId")
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func setupActivityIndicator() {
    view.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func loadTrendingGames() {
    activityIndicator.startAnimating()
    RawgProvider.shared.getGames(pageSize: 10) { result in
      switch result {
      case .success(let games):
        self.trendingContent = games
        self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
      case .failure(let error):
        let alert = UIAlertController(
          title: "Oops! Something went wrong",
          message: "\(error.localizedDescription)",
          preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Try Again", style: .default) { _ in
          self.loadTrendingGames()
        })
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 1
    case 2:
      return trendingContent?.count ?? 0
    default:
      return 0
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      if let cell = tableView.dequeueReusableCell(
        withIdentifier: "welcomeCellId",
        for: indexPath
      ) as? WelcomeTableViewCell {
        if trendingContent != nil {
          cell.titleLabel.text = "Hai, Rose!"
          cell.profileImageView.image = UIImage(named: "dummyProfile")
        } else {
          return UITableViewCell()
        }
        return cell
      } else {
        return UITableViewCell()
      }
    case 1:
      if let cell = tableView.dequeueReusableCell(
        withIdentifier: "trendingCellId",
        for: indexPath
      ) as? TrendingTableViewCell {
        if trendingContent != nil {
          cell.titleLabel.text = "Trending"
        } else {
          return UITableViewCell()
        }
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.reloadData()
        return cell
      } else {
        return UITableViewCell()
      }
    case 2:
      if let cell = tableView.dequeueReusableCell(
        withIdentifier: "freeGamesCellId",
        for: indexPath
      ) as? FreeGamesTableViewCell {
        if let result = trendingContent?[indexPath.row] {
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
    default:
      return UITableViewCell()
    }
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.section == 2 {
      let viewController = DetailViewController()
      viewController.id = Int(trendingContent?[indexPath.row].id ?? 0)
      viewController.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 2 && trendingContent != nil {
      let view = UIView(frame: .zero)
      let label = UILabel(frame: .zero)
      label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      label.textColor = .black
      label.text = "Top Free Games"
      view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      return view
    } else {
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 2:
      return 50
    default:
      return 0.0001
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0001
  }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return trendingContent?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "trendingCellId",
      for: indexPath
    ) as? TrendingCollectionViewCell {
      let games = trendingContent?[indexPath.item]
      let urlImage = games?.backgroundImage ?? ""
      cell.loadingView.startAnimating()
      cell.imageView.kf.setImage(with: URL(string: urlImage)) { _ in
        cell.loadingView.stopAnimating()
      }
      cell.loadingView.startAnimating()
      cell.thumbImageView.kf.setImage(with: URL(string: urlImage)) { _ in
        cell.loadingView.stopAnimating()
      }
      cell.nameLabel.text = games?.name
      cell.genreLabel.text = games?.genres?.last?.name
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.id = Int(trendingContent?[indexPath.item].id ?? 0)
    viewController.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: 250, height: 350)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 10
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0.0001
  }
}

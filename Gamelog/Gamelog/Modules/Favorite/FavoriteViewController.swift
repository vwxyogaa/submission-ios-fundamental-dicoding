//
//  FavoriteViewController.swift
//  Gamelog
//
//  Created by yxgg on 25/04/22.
//

import UIKit

class FavoriteViewController: UIViewController {
  var listGame: [FavoriteModel] = []
  var id: Int = 0
  
  // MARK: - Views
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.separatorStyle = .none
    tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  lazy var deleteAllButton: UIBarButtonItem = {
    let deleteAllButton = UIBarButtonItem(
      title: "Delete All",
      style: .plain,
      target: self,
      action: #selector(self.deleteAllButtonTapped(_:))
    )
    deleteAllButton.tintColor = .black
    return deleteAllButton
  }()
  
  lazy var labelNoData: UILabel = {
    let labelNoData = UILabel()
    labelNoData.text = "You dont have any favorite game"
    labelNoData.textAlignment = .center
    labelNoData.sizeToFit()
    return labelNoData
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTableView()
    setupDeleteAllButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadFavorites()
  }
  
  // MARK: - Helpers
  private func loadFavorites() {
    RawgGameProvider.shared.getAllFavorite { favorites in
      DispatchQueue.main.async {
        self.listGame = favorites
        self.tableView.reloadData()
        if self.listGame.isEmpty {
          self.setupLabelNoData()
        } else {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  private func setupViews() {
    title = "Favorite"
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
    tableView.register(FreeGamesTableViewCell.self, forCellReuseIdentifier: "favoriteGamesCellId")
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func setupLabelNoData() {
    tableView.backgroundView = labelNoData
  }
  
  private func setupDeleteAllButton() {
    navigationItem.rightBarButtonItem = deleteAllButton
  }
  
  private func deleteAllFavorite() {
    RawgGameProvider.shared.deleteAllFavorite {
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Succesful", message: "Deleted all favorite.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Actions
  @objc private func deleteAllButtonTapped(_ sender: Any) {
    let alert = UIAlertController(
      title: "Warning",
      message: "Do you want delete all game from favorite?",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
      self.deleteAllFavorite()
    })
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listGame.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "favoriteGamesCellId",
      for: indexPath
    ) as? FreeGamesTableViewCell else {
      return UITableViewCell()
    }
    let games = listGame[indexPath.row]
    if let image = games.thumbImage {
      cell.thumbImageView.image = UIImage(data: image)
    }
    cell.nameLabel.text = games.name
    cell.releaseLabel.text = games.release
    cell.subtitleLabel.text = "\(games.rating ?? "") • \(games.genre ?? "")"
    return cell
  }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let viewController = DetailViewController()
    viewController.id = Int(listGame[indexPath.row].id ?? 0)
    viewController.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

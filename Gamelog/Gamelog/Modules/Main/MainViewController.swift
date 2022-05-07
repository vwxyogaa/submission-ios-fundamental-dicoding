//
//  MainViewController.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit

class MainViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    tabBar.tintColor = .black
    tabBar.unselectedItemTintColor = .lightGray
    
    let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
    homeNavigationController.title = "Gamelog"
    homeNavigationController.tabBarItem.image = UIImage(named: "tabHomeUnselected")
    homeNavigationController.tabBarItem.selectedImage = UIImage(named: "tabHome")
    
    let searchNavigationController = UINavigationController(rootViewController: SearchViewController())
    searchNavigationController.title = "Search"
    searchNavigationController.tabBarItem.image = UIImage(named: "tabSearchUnselected")
    searchNavigationController.tabBarItem.selectedImage = UIImage(named: "tabSearch")
    
    let favoriteNavigationController = UINavigationController(rootViewController: FavoriteViewController())
    favoriteNavigationController.title = "Favorite"
    favoriteNavigationController.tabBarItem.image = UIImage(named: "tabFavoriteUnselected")
    favoriteNavigationController.tabBarItem.selectedImage = UIImage(named: "tabFavorite")
    
    let aboutNavigationController = UINavigationController(rootViewController: AboutViewController())
    aboutNavigationController.title = "About"
    aboutNavigationController.tabBarItem.image = UIImage(named: "tabAboutUnselected")
    aboutNavigationController.tabBarItem.selectedImage = UIImage(named: "tabAbout")
    
    viewControllers = [
      homeNavigationController,
      searchNavigationController,
      favoriteNavigationController,
      aboutNavigationController
    ]
  }
}

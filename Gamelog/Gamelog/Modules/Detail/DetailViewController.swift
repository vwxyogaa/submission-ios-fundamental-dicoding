//
//  DetailViewController.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit
import Kingfisher
import SafariServices

class DetailViewController: UIViewController {
  var isFavorite: Bool = false
  var id: Int?
  var detailGame: DetailRawg?
  
  // MARK: - Views
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  lazy var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  lazy var thumbImageView: UIImageView = {
    let thumbImageView = UIImageView()
    thumbImageView.contentMode = .scaleAspectFill
    thumbImageView.layer.cornerRadius = 10
    thumbImageView.layer.masksToBounds = true
    return thumbImageView
  }()
  
  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    nameLabel.numberOfLines = 1
    return nameLabel
  }()
  
  lazy var genreLabel: UILabel = {
    let genreLabel = UILabel()
    genreLabel.textColor = .black
    genreLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    genreLabel.numberOfLines = 1
    return genreLabel
  }()
  
  lazy var favoriteButton: UIButton = {
    let favoriteButton = UIButton(type: .system)
    favoriteButton.tintColor = .red
    return favoriteButton
  }()
  
  lazy var aboutTitleLabel: UILabel = {
    let aboutTitleLabel = UILabel()
    aboutTitleLabel.textColor = .black
    aboutTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    aboutTitleLabel.numberOfLines = 1
    return aboutTitleLabel
  }()
  
  lazy var aboutLabel: UILabel = {
    let aboutLabel = UILabel()
    aboutLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    aboutLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    aboutLabel.numberOfLines = 0
    return aboutLabel
  }()
  
  lazy var platformTitleLabel: UILabel = {
    let platformTitleLabel = UILabel()
    platformTitleLabel.textColor = .black
    platformTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    platformTitleLabel.numberOfLines = 1
    return platformTitleLabel
  }()
  
  lazy var platformLabel: UILabel = {
    let platformLabel = UILabel()
    platformLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    platformLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    platformLabel.numberOfLines = 0
    return platformLabel
  }()
  
  lazy var developerTitleLabel: UILabel = {
    let developerTitleLabel = UILabel()
    developerTitleLabel.textColor = .black
    developerTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    developerTitleLabel.numberOfLines = 1
    return developerTitleLabel
  }()
  
  lazy var developerLabel: UILabel = {
    let developerLabel = UILabel()
    developerLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    developerLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    developerLabel.numberOfLines = 0
    return developerLabel
  }()
  
  lazy var publisherTitleLabel: UILabel = {
    let publisherTitleLabel = UILabel()
    publisherTitleLabel.textColor = .black
    publisherTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    publisherTitleLabel.numberOfLines = 1
    return publisherTitleLabel
  }()
  
  lazy var publisherLabel: UILabel = {
    let publisherLabel = UILabel()
    publisherLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    publisherLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    publisherLabel.numberOfLines = 0
    return publisherLabel
  }()
  
  lazy var releaseTitleLabel: UILabel = {
    let releaseTitleLabel = UILabel()
    releaseTitleLabel.textColor = .black
    releaseTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    releaseTitleLabel.numberOfLines = 1
    return releaseTitleLabel
  }()
  
  lazy var releaseLabel: UILabel = {
    let releaseLabel = UILabel()
    releaseLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    releaseLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    releaseLabel.numberOfLines = 0
    return releaseLabel
  }()
  
  lazy var ratingTitleLabel: UILabel = {
    let ratingTitleLabel = UILabel()
    ratingTitleLabel.textColor = .black
    ratingTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    ratingTitleLabel.numberOfLines = 1
    return ratingTitleLabel
  }()
  
  lazy var ratingLabel: UILabel = {
    let ratingLabel = UILabel()
    ratingLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    ratingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    ratingLabel.numberOfLines = 0
    return ratingLabel
  }()
  
  lazy var tagsTitleLabel: UILabel = {
    let tagsTitleLabel = UILabel()
    tagsTitleLabel.textColor = .black
    tagsTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    tagsTitleLabel.numberOfLines = 1
    return tagsTitleLabel
  }()
  
  lazy var tagsLabel: UILabel = {
    let tagsLabel = UILabel()
    tagsLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    tagsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    tagsLabel.numberOfLines = 0
    return tagsLabel
  }()
  
  lazy var websiteTitleLabel: UILabel = {
    let websiteTitleLabel = UILabel()
    websiteTitleLabel.textColor = .black
    websiteTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    websiteTitleLabel.numberOfLines = 1
    return websiteTitleLabel
  }()
  
  lazy var websiteLabel: UILabel = {
    let websiteLabel = UILabel()
    websiteLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    websiteLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    websiteLabel.numberOfLines = 0
    return websiteLabel
  }()
  
  lazy var loadMoreButton: UIButton = {
    let loadMoreButton = UIButton(type: .system)
    loadMoreButton.setTitle("Load More", for: .normal)
    loadMoreButton.setTitleColor(UIColor.black, for: .normal)
    loadMoreButton.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    loadMoreButton.layer.cornerRadius = 10
    loadMoreButton.layer.masksToBounds = true
    return loadMoreButton
  }()
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .large
    return activityIndicator
  }()
  
  lazy var loadingImage: UIActivityIndicatorView = {
    let loadingImage = UIActivityIndicatorView()
    loadingImage.hidesWhenStopped = true
    loadingImage.style = .large
    return loadingImage
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupScrollView()
    setupContentView()
    setupImageView()
    setupThumbImageView()
    setupNameLabel()
    setupGenreLabel()
    setupFavoriteButton()
    setupAboutTitleLabel()
    setupAboutLabel()
    setupPlatformTitleLabel()
    setupPlatformLabel()
    setupDeveloperTitleLabel()
    setupDeveloperLabel()
    setupPublisherTitleLabel()
    setupPublisherLabel()
    setupReleaseTitleLabel()
    setupReleaseLabel()
    setupRatingTitleLabel()
    setupRatingLabel()
    setupTagsTitleLabel()
    setupTagsLabel()
    setupWebsiteTitleLabel()
    setupWebsiteLabel()
    setupLoadMoreButton()
    setupActivityIndicator()
    setupLoadingImage()
    setupFavoriteData()
    isGameFavorite()
  }
  
  private func setupFavoriteData() {
    if isFavorite {
      loadFavoriteDatabase()
    } else {
      loadGames()
    }
  }
  
  private func isGameFavorite() {
    guard let id = id else { return }
    RawgGameProvider.shared.checkGameData(id) { favorites in
      self.isFavorite = favorites
      DispatchQueue.main.async {
        if self.isFavorite {
          self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
          self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
      }
    }
  }
  
  private func setupViews() {
    view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    title = "Detail Game"
    navigationItem.largeTitleDisplayMode = .never
  }
  
  private func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func setupContentView() {
    scrollView.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }
  
  private func setupImageView() {
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: 300),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
    ])
  }
  
  private func setupThumbImageView() {
    contentView.addSubview(thumbImageView)
    thumbImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      thumbImageView.heightAnchor.constraint(equalToConstant: 100),
      thumbImageView.widthAnchor.constraint(equalToConstant: 100),
      thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      thumbImageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupNameLabel() {
    contentView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 10),
      nameLabel.topAnchor.constraint(equalTo: thumbImageView.topAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupGenreLabel() {
    contentView.addSubview(genreLabel)
    genreLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      genreLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      genreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      genreLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
    ])
  }
  
  private func setupFavoriteButton() {
    contentView.addSubview(favoriteButton)
    if isFavorite {
      favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
      favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    favoriteButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      favoriteButton.heightAnchor.constraint(equalToConstant: 30),
      favoriteButton.widthAnchor.constraint(equalToConstant: 30),
      favoriteButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      favoriteButton.bottomAnchor.constraint(equalTo: thumbImageView.bottomAnchor)
    ])
    favoriteButton.addTarget(self, action: #selector(self.favoriteButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupAboutTitleLabel() {
    contentView.addSubview(aboutTitleLabel)
    aboutTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      aboutTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      aboutTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      aboutTitleLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupAboutLabel() {
    contentView.addSubview(aboutLabel)
    aboutLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      aboutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      aboutLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupPlatformTitleLabel() {
    contentView.addSubview(platformTitleLabel)
    platformTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      platformTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      platformTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      platformTitleLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupPlatformLabel() {
    contentView.addSubview(platformLabel)
    platformLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      platformLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      platformLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      platformLabel.topAnchor.constraint(equalTo: platformTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupDeveloperTitleLabel() {
    contentView.addSubview(developerTitleLabel)
    developerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      developerTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      developerTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      developerTitleLabel.topAnchor.constraint(equalTo: platformLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupDeveloperLabel() {
    contentView.addSubview(developerLabel)
    developerLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      developerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      developerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      developerLabel.topAnchor.constraint(equalTo: developerTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupPublisherTitleLabel() {
    contentView.addSubview(publisherTitleLabel)
    publisherTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      publisherTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      publisherTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      publisherTitleLabel.topAnchor.constraint(equalTo: developerLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupPublisherLabel() {
    contentView.addSubview(publisherLabel)
    publisherLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      publisherLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      publisherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      publisherLabel.topAnchor.constraint(equalTo: publisherTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupReleaseTitleLabel() {
    contentView.addSubview(releaseTitleLabel)
    releaseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      releaseTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      releaseTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      releaseTitleLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupReleaseLabel() {
    contentView.addSubview(releaseLabel)
    releaseLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      releaseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      releaseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      releaseLabel.topAnchor.constraint(equalTo: releaseTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupRatingTitleLabel() {
    contentView.addSubview(ratingTitleLabel)
    ratingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ratingTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      ratingTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      ratingTitleLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupRatingLabel() {
    contentView.addSubview(ratingLabel)
    ratingLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      ratingLabel.topAnchor.constraint(equalTo: ratingTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupTagsTitleLabel() {
    contentView.addSubview(tagsTitleLabel)
    tagsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tagsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      tagsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      tagsTitleLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupTagsLabel() {
    contentView.addSubview(tagsLabel)
    tagsLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tagsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      tagsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      tagsLabel.topAnchor.constraint(equalTo: tagsTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupWebsiteTitleLabel() {
    contentView.addSubview(websiteTitleLabel)
    websiteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      websiteTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      websiteTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      websiteTitleLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupWebsiteLabel() {
    contentView.addSubview(websiteLabel)
    websiteLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      websiteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      websiteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      websiteLabel.topAnchor.constraint(equalTo: websiteTitleLabel.bottomAnchor)
    ])
  }
  
  private func setupLoadMoreButton() {
    contentView.addSubview(loadMoreButton)
    loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadMoreButton.heightAnchor.constraint(equalToConstant: 48),
      loadMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      loadMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      loadMoreButton.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 16),
      loadMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
    loadMoreButton.addTarget(self, action: #selector(self.loadMoreButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupActivityIndicator() {
    contentView.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
  
  private func setupLoadingImage() {
    contentView.addSubview(loadingImage)
    loadingImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      loadingImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
    ])
  }
  
  private func loadGames() {
    guard let id = id else { return }
    activityIndicator.startAnimating()
    favoriteButton.isHidden = true
    loadMoreButton.isHidden = true
    RawgProvider.shared.getDetail(id: id) { result in
      switch result {
      case .success(let games):
        self.detailGame = games
        self.activityIndicator.stopAnimating()
        self.favoriteButton.isHidden = false
        self.loadMoreButton.isHidden = false
        if let result = self.detailGame {
          let urlImage = result.backgroundImageAdditional
          self.loadingImage.startAnimating()
          self.imageView.kf.setImage(with: URL(string: urlImage)) {_ in
            self.loadingImage.stopAnimating()
          }
          let urlThumbImage = result.backgroundImage
          self.thumbImageView.kf.setImage(with: URL(string: urlThumbImage))
          self.nameLabel.text = result.name
          self.genreLabel.text = result.genres.last?.name
          self.aboutTitleLabel.text = "About"
          self.aboutLabel.text = result.description
          self.platformTitleLabel.text = "Platforms"
          let platformArray = result.platforms.map {$0.platform.name}
          self.platformLabel.text = platformArray.joined(separator: ", ")
          self.developerTitleLabel.text = "Developer"
          self.developerLabel.text = "\(result.developers.last?.name ?? "")"
          self.publisherTitleLabel.text = "Publisher"
          self.publisherLabel.text = "\(result.publishers.last?.name ?? "")"
          self.releaseTitleLabel.text = "Release date"
          self.releaseLabel.text = result.released.string(format: "MMM dd, yyyy")
          self.ratingTitleLabel.text = "Rating"
          self.ratingLabel.text = "\(result.rating)"
          self.tagsTitleLabel.text = "Tags"
          let tagsArray = result.tags.map {$0.name}
          self.tagsLabel.text = tagsArray.joined(separator: ", ")
          self.websiteTitleLabel.text = "Website"
          self.websiteLabel.text = result.website
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func loadFavoriteDatabase() {
    guard let favoriteId = id else { return }
    RawgGameProvider.shared.getFavorite(favoriteId) { favorites in
      DispatchQueue.main.async {
        if let backgroundImage = favorites.backgroundImage {
          self.imageView.image = UIImage(data: backgroundImage)
        }
        if let thumbImage = favorites.thumbImage {
          self.thumbImageView.image = UIImage(data: thumbImage)
        }
        self.nameLabel.text = favorites.name
        self.genreLabel.text = favorites.genre; self.aboutTitleLabel.text = "About"
        self.aboutLabel.text = favorites.description; self.platformTitleLabel.text = "Platforms"
        self.platformLabel.text = favorites.platform; self.developerTitleLabel.text = "Developer"
        self.developerLabel.text = favorites.developer; self.publisherTitleLabel.text = "Publisher"
        self.publisherLabel.text = favorites.publisher; self.releaseTitleLabel.text = "Release date"
        self.releaseLabel.text = favorites.release; self.ratingTitleLabel.text = "Rating"
        self.ratingLabel.text = favorites.rating; self.tagsTitleLabel.text = "Tags"
        self.tagsLabel.text = favorites.tags; self.websiteTitleLabel.text = "Website"
        self.websiteLabel.text = favorites.website
      }
    }
  }
  
  private func saveGame() {
    guard let id = id else { return }
    guard let name = nameLabel.text else { return }
    guard let genre = genreLabel.text else { return }
    guard let desc = aboutLabel.text else { return }
    guard let platform = platformLabel.text else { return }
    guard let developer = developerLabel.text else { return }
    guard let publisher = publisherLabel.text else { return }
    guard let release = releaseLabel.text else { return }
    guard let rating = ratingLabel.text else { return }
    guard let tags = tagsLabel.text else { return }
    guard let website = websiteLabel.text else { return }
    guard let backgroundImage = imageView.image,
          let dataBackgroundImage = backgroundImage.pngData() as NSData? else { return }
    guard let thumbImage = thumbImageView.image,
          let dataThumbImage = thumbImage.pngData() as NSData? else { return }
    
    RawgGameProvider.shared.createFavorite(
      id,
      dataBackgroundImage as Data,
      dataThumbImage as Data,
      name, genre, desc, platform, developer, publisher, release, rating, tags, website) {
        DispatchQueue.main.async {
          self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
          let alert = UIAlertController(title: "Successful", message: "Save to favorite.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
          })
          self.present(alert, animated: true, completion: nil)
        }
      }
  }
  
  private func deleteFromFavorite(_ id: Int) {
    RawgGameProvider.shared.deleteFavorite(id) {
      DispatchQueue.main.async {
        self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        let alert = UIAlertController(title: "Successful", message: "Deleted from favorite.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  // MARK: - Actions
  @objc private func getButtonTapped(_ sender: Any) {
    presentAlert(title: "Oops", message: "This feature will available soon") { _ in }
  }
  
  @objc private func favoriteButtonTapped(_ sender: Any) {
    if isFavorite {
      guard let id = id else { return }
      deleteFromFavorite(id)
    } else {
      saveGame()
    }
    isFavorite = !isFavorite
  }
  
  @objc private func loadMoreButtonTapped(_ sender: Any) {
    if let url = URL(string: detailGame?.website ?? "") {
      let viewController = SFSafariViewController(url: url)
      present(viewController, animated: true, completion: nil)
    }
  }
}

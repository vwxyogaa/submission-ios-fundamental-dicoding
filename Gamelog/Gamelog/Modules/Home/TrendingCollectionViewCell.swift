//
//  TrendingCollectionViewCell.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
  // MARK: - Views
  lazy var containerView: UIView = {
    let containerView = UIView()
    containerView.backgroundColor = .white
    containerView.layer.cornerRadius = 10
    containerView.layer.masksToBounds = true
    return containerView
  }()
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 10
    imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    imageView.layer.masksToBounds = true
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
    nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    nameLabel.numberOfLines = 1
    return nameLabel
  }()
  
  lazy var genreLabel: UILabel = {
    let genreLabel = UILabel()
    genreLabel.textColor = .black
    genreLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    genreLabel.numberOfLines = 1
    return genreLabel
  }()
  
  lazy var loadingView: UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView()
    loadingView.hidesWhenStopped = true
    loadingView.style = .large
    return loadingView
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupContainerView()
    setupImageView()
    setupThumbImageView()
    setupNameLabel()
    setupGenreLabel()
    setupLoadingView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupContainerView()
    setupImageView()
    setupThumbImageView()
    setupNameLabel()
    setupGenreLabel()
    setupLoadingView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupContainerView()
    setupImageView()
    setupThumbImageView()
    setupNameLabel()
    setupGenreLabel()
    setupLoadingView()
  }
  
  // MARK: - Helpers
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  private func setupImageView() {
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 280)
    ])
  }
  
  private func setupThumbImageView() {
    contentView.addSubview(thumbImageView)
    thumbImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      thumbImageView.heightAnchor.constraint(equalToConstant: 50),
      thumbImageView.widthAnchor.constraint(equalToConstant: 50),
      thumbImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      thumbImageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      thumbImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
    ])
  }
  
  private func setupNameLabel() {
    contentView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      nameLabel.topAnchor.constraint(equalTo: thumbImageView.topAnchor)
    ])
  }
  
  private func setupGenreLabel() {
    contentView.addSubview(genreLabel)
    genreLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      genreLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      genreLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      genreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
    ])
  }
  
  private func setupLoadingView() {
    contentView.addSubview(loadingView)
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      loadingView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])
  }
}

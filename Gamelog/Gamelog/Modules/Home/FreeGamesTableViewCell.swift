//
//  FreeGamesTableViewCell.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit

class FreeGamesTableViewCell: UITableViewCell {
  // MARK: - Views
  lazy var thumbImageView: UIImageView = {
    let thumbImageView = UIImageView()
    thumbImageView.contentMode = .scaleAspectFill
    thumbImageView.layer.cornerRadius = 15
    thumbImageView.layer.masksToBounds = true
    return thumbImageView
  }()
  
  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    return nameLabel
  }()
  
  lazy var releaseLabel: UILabel = {
    let releaseLabel = UILabel()
    releaseLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    releaseLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    return releaseLabel
  }()
  
  lazy var ratingIcon: UIImageView = {
    let ratingIcon = UIImageView()
    return ratingIcon
  }()
  
  lazy var subtitleLabel: UILabel = {
    let subtitleLabel = UILabel()
    subtitleLabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    return subtitleLabel
  }()
  
  lazy var loadingView: UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView()
    loadingView.style = .medium
    loadingView.hidesWhenStopped = true
    return loadingView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupThumbImageView()
    setupNameLabel()
    setupReleaseLabel()
    setupRatingIcon()
    setupSubtitleLabel()
    setupLoadingView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupThumbImageView()
    setupNameLabel()
    setupReleaseLabel()
    setupRatingIcon()
    setupSubtitleLabel()
    setupLoadingView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
    setupThumbImageView()
    setupNameLabel()
    setupReleaseLabel()
    setupRatingIcon()
    setupSubtitleLabel()
    setupLoadingView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - Helpers
  private func setupViews() {
    backgroundColor = .clear
  }
  
  private func setupThumbImageView() {
    contentView.addSubview(thumbImageView)
    thumbImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      thumbImageView.heightAnchor.constraint(equalToConstant: 70),
      thumbImageView.widthAnchor.constraint(equalToConstant: 70),
      thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      thumbImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  private func setupNameLabel() {
    contentView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: thumbImageView.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupReleaseLabel() {
    contentView.addSubview(releaseLabel)
    releaseLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      releaseLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
      releaseLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      releaseLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
    ])
  }
  
  private func setupRatingIcon() {
    contentView.addSubview(ratingIcon)
    ratingIcon.image = UIImage(named: "ratingIcon")
    ratingIcon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ratingIcon.widthAnchor.constraint(equalToConstant: 15),
      ratingIcon.heightAnchor.constraint(equalToConstant: 15),
      ratingIcon.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 10),
      ratingIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  private func setupSubtitleLabel() {
    contentView.addSubview(subtitleLabel)
    subtitleLabel.text = "2.23 • Sports"
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 5),
      subtitleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  private func setupLoadingView() {
    contentView.addSubview(loadingView)
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingView.centerXAnchor.constraint(equalTo: thumbImageView.centerXAnchor),
      loadingView.centerYAnchor.constraint(equalTo: thumbImageView.centerYAnchor)
    ])
  }
}

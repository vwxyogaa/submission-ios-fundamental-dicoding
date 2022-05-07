//
//  WelcomeTableViewCell.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {
  // MARK: - Views
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    titleLabel.textColor = .black
    titleLabel.numberOfLines = 1
    return titleLabel
  }()
  
  lazy var profileImageView: UIImageView = {
    let profileImageView = UIImageView()
    profileImageView.contentMode = .scaleAspectFill
    profileImageView.layer.cornerRadius = 25
    profileImageView.layer.masksToBounds = true
    profileImageView.layer.borderWidth = 1
    profileImageView.layer.borderColor = UIColor.black.cgColor
    return profileImageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupTitleLabel()
    setupProfileImageView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupTitleLabel()
    setupProfileImageView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
    setupTitleLabel()
    setupProfileImageView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - Helpers
  private func setupViews() {
    backgroundColor = .clear
    selectionStyle = .none
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
  }
  
  private func setupProfileImageView() {
    contentView.addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileImageView.heightAnchor.constraint(equalToConstant: 50),
      profileImageView.widthAnchor.constraint(equalToConstant: 50),
      profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      profileImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
    ])
  }
}

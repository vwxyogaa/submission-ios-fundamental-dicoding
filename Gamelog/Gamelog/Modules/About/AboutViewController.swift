//
//  AboutViewController.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import UIKit

class AboutViewController: UIViewController {
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
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = 100
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  lazy var nameTextView: UITextView = {
    let nameTextView = UITextView()
    nameTextView.isScrollEnabled = false
    nameTextView.isEditable = false
    nameTextView.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    nameTextView.textColor = .black
    nameTextView.backgroundColor = .clear
    nameTextView.textAlignment = .center
    return nameTextView
  }()
  
  lazy var emailTextView: UITextView = {
    let emailTextView = UITextView()
    emailTextView.isScrollEnabled = false
    emailTextView.isEditable = false
    emailTextView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    emailTextView.textColor = .black
    emailTextView.backgroundColor = .clear
    emailTextView.textAlignment = .center
    return emailTextView
  }()
  
  lazy var editProfilButton: UIButton = {
    let editProfilButton = UIButton(type: .system)
    editProfilButton.setTitleColor(UIColor.black, for: .normal)
    editProfilButton.layer.cornerRadius = 5
    editProfilButton.layer.masksToBounds = true
    editProfilButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    editProfilButton.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    return editProfilButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupScrollView()
    setupContentView()
    setupImageView()
    setupNameTextView()
    setupEmailTextView()
    setupEditProfilButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    ProfileModel.synchronize()
    nameTextView.text = ProfileModel.name
    emailTextView.text = ProfileModel.email
  }
  
  // MARK: - Helpers
  private func setupViews() {
    title = "About"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
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
    imageView.image = UIImage(named: "dummyProfile")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: 200),
      imageView.heightAnchor.constraint(equalToConstant: 200),
      imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
  
  private func setupNameTextView() {
    contentView.addSubview(nameTextView)
    nameTextView.text = "Name"
    nameTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
      nameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      nameTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupEmailTextView() {
    contentView.addSubview(emailTextView)
    emailTextView.text = "Email"
    emailTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 4),
      emailTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      emailTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupEditProfilButton() {
    contentView.addSubview(editProfilButton)
    editProfilButton.setTitle("Edit Profile", for: .normal)
    editProfilButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      editProfilButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      editProfilButton.topAnchor.constraint(equalTo: emailTextView.bottomAnchor, constant: 24),
      editProfilButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
    editProfilButton.addTarget(self, action: #selector(self.editProfilButtonTapped(_:)), for: .touchUpInside)
  }
  
  // MARK: - Actions
  @objc private func editProfilButtonTapped(_ sender: Any) {
    let viewController = EditProfileViewController()
    viewController.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

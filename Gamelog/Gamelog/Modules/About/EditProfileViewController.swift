//
//  EditProfileViewController.swift
//  Gamelog
//
//  Created by yxgg on 25/04/22.
//

import UIKit

class EditProfileViewController: UIViewController {
  // MARK: - Views
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = 100
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  lazy var nameTextField: UITextField = {
    let nameTextField = UITextField()
    nameTextField.placeholder = "Name"
    nameTextField.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    nameTextField.layer.cornerRadius = 5
    nameTextField.layer.masksToBounds = true
    let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
    nameTextField.leftView = paddingView
    nameTextField.leftViewMode = .always
    return nameTextField
  }()
  
  lazy var emailTextField: UITextField = {
    let emailTextField = UITextField()
    emailTextField.placeholder = "Email"
    emailTextField.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    emailTextField.layer.cornerRadius = 5
    emailTextField.layer.masksToBounds = true
    let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
    emailTextField.leftView = paddingView
    emailTextField.leftViewMode = .always
    return emailTextField
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 20
    return stackView
  }()
  
  lazy var saveButton: UIButton = {
    let saveButton = UIButton(type: .system)
    saveButton.setTitle("Save", for: .normal)
    saveButton.setTitleColor(UIColor.black, for: .normal)
    saveButton.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    saveButton.layer.cornerRadius = 5
    saveButton.layer.masksToBounds = true
    return saveButton
  }()
  
  lazy var cancelButton: UIButton = {
    let cancelButton = UIButton(type: .system)
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.setTitleColor(UIColor.black, for: .normal)
    cancelButton.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    cancelButton.layer.cornerRadius = 5
    cancelButton.layer.masksToBounds = true
    return cancelButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupImageView()
    setupNameTextField()
    setupEmailTextField()
    setupSaveButton()
    setupCancelButton()
    setupStackView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    ProfileModel.synchronize()
    nameTextField.text = ProfileModel.name
    emailTextField.text = ProfileModel.email
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    title = "Edit Profile"
    navigationItem.largeTitleDisplayMode = .never
  }
  
  private func setupImageView() {
    view.addSubview(imageView)
    imageView.backgroundColor = .black
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: 200),
      imageView.heightAnchor.constraint(equalToConstant: 200),
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  private func setupNameTextField() {
    view.addSubview(nameTextField)
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameTextField.heightAnchor.constraint(equalToConstant: 52),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupEmailTextField() {
    view.addSubview(emailTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailTextField.heightAnchor.constraint(equalToConstant: 52),
      emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupStackView() {
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      stackView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupSaveButton() {
    stackView.addArrangedSubview(saveButton)
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupCancelButton() {
    stackView.addArrangedSubview(cancelButton)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    cancelButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor).isActive = true
    cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func saveProfil(_ name: String, _ email: String) {
    ProfileModel.stateLogin = true
    ProfileModel.name = name
    ProfileModel.email = email
  }
  
  private func textEmpty(_ field: String) {
    let alert = UIAlertController(
      title: "Alert",
      message: "\(field) is empty",
      preferredStyle: UIAlertController.Style.alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Actions
  @objc private func saveButtonTapped(_ sender: Any) {
    if let name = nameTextField.text, let email = emailTextField.text {
      if name.isEmpty {
        textEmpty("Name")
      } else if email.isEmpty {
        textEmpty("Email")
      } else {
        saveProfil(name, email)
        navigationController?.popViewController(animated: true)
      }
    }
  }
  
  @objc private func cancelButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

//
//  SettingsViewController.swift
//  DelegationApp
//
//  Created by Matvei Khlestov on 07.04.2024.
//

import UIKit

// MARK: - SettingsViewController
final class SettingsViewController: UIViewController {
    
    // MARK: - Public Properties
    weak var delegate: SettingsViewControllerDelegate!
    
    // MARK: - UI Elements
    private lazy var nameLabel: UILabel = {
        createLabel(
            origin:
                CGPoint(
                    x: 42,
                    y: 155
                ),
            size:
                CGSize(
                    width: 34,
                    height: 19
                ),
            text: "Имя"
        )
    }()
    
    private lazy var surnameLabel: UILabel = {
        createLabel(
            origin:
                CGPoint(
                    x: 42,
                    y: nameTextField.frame.origin.y + 73
                ),
            size:
                CGSize(
                    width: 70,
                    height: 19
                ),
            text: "Фамилия"
        )
    }()
    
    private lazy var descriptionLabel: UILabel = {
        createLabel(
            origin:
                CGPoint(
                    x: 42,
                    y: surnameTextField.frame.origin.y + 73
                ),
            size:
                CGSize(
                    width: 80,
                    height: 19
                ),
            text: "Описание"
        )
    }()
    
    private lazy var nameTextField: UITextField = {
        createTextField(
            origin:
                CGPoint(
                    x: 30,
                    y: nameLabel.frame.origin.y + 24
                )
        )
    }()
    
    private lazy var surnameTextField: UITextField = {
        createTextField(
            origin:
                CGPoint(
                    x: 30,
                    y: surnameLabel.frame.origin.y + 24
                )
        )
    }()
    
    private lazy var descriptionTextView: UITextView = {
        createTextView()
    }()
    
    private lazy var saveButton: UIButton = {
        createButton()
    }()
    
    // MARK: -  Action
    private lazy var saveButtonAction = UIAction { [ weak self ] _ in
        guard let self = self else { return }
        self.saveButtonTapped()
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension SettingsViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupNavigationController()
    }
    
    func addSubviews() {
        setupSubviews(
            nameLabel,
            nameTextField,
            surnameLabel,
            surnameTextField,
            descriptionLabel,
            descriptionTextView,
            saveButton
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationController() {
        title = "Настройки"
    }
    
    func saveButtonTapped() {
        delegate.setNewValues(
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? "",
            personalInfo: descriptionTextView.text ?? ""
        )
        
        navigationController?.popViewController(animated: true)
    }
    
    func createLabel(origin: CGPoint, size: CGSize, text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }
    
    func createTextField(origin: CGPoint) -> UITextField {
        let size = CGSize(width: view.frame.width - 60, height: 51)
        
        let textField = UITextField()
        textField.backgroundColor = .backgroundView
        textField.frame = CGRect(origin: origin, size: size)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.rightViewMode = .always
        textField.font = .systemFont(ofSize: 16)
        textField.layer.cornerRadius = 15
        
        return textField
    }
    
    func createTextView() -> UITextView {
        let origin = CGPoint(x: 30, y: descriptionLabel.frame.origin.y + 24)
        let size = CGSize(width: view.frame.width - 60, height: 144)
        
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.contentInset = UIEdgeInsets(top: 22, left: 12, bottom: 22, right: 15)
        textView.backgroundColor = .backgroundView
        textView.frame = CGRect(origin: origin, size: size)
        textView.layer.cornerRadius = 20
        
        return textView
    }
    
    func createButton() -> UIButton {
        let origin = CGPoint(x: 30, y: view.frame.height - 133)
        let size = CGSize(width: view.frame.width - 60, height: 60)
        
        let button = UIButton(type: .system, primaryAction: saveButtonAction)
        button.frame = CGRect(origin: origin, size: size)
        button.backgroundColor = .backgroundButton
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        
        return button
    }
}

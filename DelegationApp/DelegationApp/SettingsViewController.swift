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
        let origin = CGPoint(x: 42, y: 155)
        let size = CGSize(width: 34, height: 19)
        
        let label = UILabel()
        label.text = "Имя"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }()
    
    private lazy var surnameLabel: UILabel = {
        let origin = CGPoint(x: 42, y: nameTextField.frame.origin.y + 73)
        let size = CGSize(width: 70, height: 19)
        
        let label = UILabel()
        label.text = "Фамилия"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let origin = CGPoint(x: 42, y: surnameTextField.frame.origin.y + 73)
        let size = CGSize(width: 80, height: 19)
        
        let label = UILabel()
        label.text = "Описание"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let origin = CGPoint(x: 30, y: nameLabel.frame.origin.y + 24)
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
    }()
    
    private lazy var surnameTextField: UITextField = {
        let origin = CGPoint(x: 30, y: surnameLabel.frame.origin.y + 24)
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
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let origin = CGPoint(x: 30, y: descriptionLabel.frame.origin.y + 24)
        let size = CGSize(width: view.frame.width - 60, height: 144)
        
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.contentInset = UIEdgeInsets(top: 22, left: 12, bottom: 22, right: 15)
        textView.backgroundColor = .backgroundView
        textView.frame = CGRect(origin: origin, size: size)
        textView.layer.cornerRadius = 20
        
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
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
    }()
    
    // MARK: -  Action
    private lazy var saveButtonAction = UIAction { [ weak self ] _ in
        guard let self = self else { return }
        self.delegate.setNewValues(
            name: self.nameTextField.text ?? "",
            surname: self.surnameTextField.text ?? "",
            personalInfo: self.descriptionTextView.text ?? ""
        )
        
        self.navigationController?.popViewController(animated: true)
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
}

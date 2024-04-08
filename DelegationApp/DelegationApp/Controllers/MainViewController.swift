//
//  MainViewController.swift
//  DelegationApp
//
//  Created by Matvei Khlestov on 07.04.2024.
//

import UIKit

// MARK: - SettingsViewControllerDelegate
protocol SettingsViewControllerDelegate: AnyObject {
    func setNewValues(name: String, surname: String, personalInfo: String)
}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    var name = "Имя"
    var surname = "Фамилия"
    var personalInfo = ""
    
    // MARK: - UI Elements
    private lazy var personView: UIView = {
        creatPersonView()
    }()
    
    private lazy var personImageView: UIImageView = {
        createImageView()
    }()
    
    private lazy var fullNameLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var editButton: UIButton = {
        createButton(
            origin:
                CGPoint(
                    x: personImageView.frame.origin.x + 87,
                    y: fullNameLabel.frame.origin.y + 26),
            size:
                CGSize(
                    width: 147,
                    height: 30
                ),
            backColor: .backgroundButton,
            title: "Редактировать",
            titleColor: .white,
            radius: 10,
            action: editButtonAction
        )
    }()
    
    private lazy var transitionButton: UIButton = {
        createButton(
            origin:
                CGPoint(
                    x: editButton.frame.origin.x + 232,
                    y: 47
                ),
            size:
                CGSize(
                    width: 17,
                    height: 17
                ),
            action: transitionButtonAction,
            image: .transition,
            tintColor: .black
        )
    }()
    
    // MARK: -  Action
    private lazy var editButtonAction = UIAction { [ weak self ] _ in
        guard let self = self else { return }
        self.editButtonTapped()
    }
    
    private lazy var transitionButtonAction = UIAction { [ weak self ] _ in
        guard let self = self else { return }
        self.transitionButtonTapped()
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension MainViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupNavigationController()
    }
    
    func addSubviews() {
        view.addSubview(personView)
    }
    
    func setupNavigationController() {
        title = "Главная"
    }
    
    func updateFullNameLabel(name: String, surname: String) {
        fullNameLabel.text = "\(name) \(surname)"
    }
    
    func updatePersonalInfo(_ info: String) {
        self.personalInfo = info
    }
    
    func editButtonTapped() {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func transitionButtonTapped() {
        let profileVC = ProfileViewController()
        profileVC.name = name
        profileVC.surname = surname
        profileVC.personalInfo = personalInfo
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func creatPersonView() -> UIView {
        let origin = CGPoint(x: 30, y: 135)
        let size = CGSize(width: view.frame.width - 60, height: 110)
        
        let personView = UIView()
        personView.addSubview(personImageView)
        personView.addSubview(fullNameLabel)
        personView.addSubview(editButton)
        personView.addSubview(transitionButton)
        personView.backgroundColor = .backgroundView
        personView.frame = CGRect(origin: origin, size: size)
        personView.layer.cornerRadius = 30
        
        return personView
    }
    
    func createImageView() -> UIImageView {
        let origin = CGPoint(x: 17, y: 18)
        let size = CGSize(width: 75, height: 75)
        
        let imageView = UIImageView()
        imageView.image = .profile
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.frame = CGRect(origin: origin, size: size)
        
        return imageView
    }
    
    func createLabel() -> UILabel {
        let origin = CGPoint(x: personImageView.frame.origin.x + 87, y: 29)
        let size = CGSize(width: 150, height: 19)
        
        let label = UILabel()
        label.text = "\(name) \(surname)"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }
    
    func createButton(origin: CGPoint,
                      size: CGSize, backColor: UIColor? = nil,
                      title: String? = nil,
                      font: UIFont? = nil,
                      titleColor: UIColor? = nil,
                      radius: CGFloat? = nil,
                      action: UIAction,
                      image: UIImage? = nil,
                      tintColor: UIColor? = nil) -> UIButton {
        
        let button = UIButton(type: .system, primaryAction: action)
        button.frame = CGRect(origin: origin, size: size)
        button.backgroundColor = backColor
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = radius ?? 0
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        
        return button
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewValues(name: String, surname: String, personalInfo: String) {
        self.name = name
        self.surname = surname
        self.personalInfo = personalInfo
        
        updatePersonalInfo(personalInfo)
        updateFullNameLabel(name: name, surname: surname)
    }
}


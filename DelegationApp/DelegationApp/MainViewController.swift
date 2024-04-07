//
//  MainViewController.swift
//  DelegationApp
//
//  Created by Matvei Khlestov on 07.04.2024.
//

import UIKit

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
    }()
    
    private lazy var personImageView: UIImageView = {
        let origin = CGPoint(x: 17, y: 18)
        let size = CGSize(width: 75, height: 75)
        
        let imageView = UIImageView()
        imageView.image = .profile
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.frame = CGRect(origin: origin, size: size)
        
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let origin = CGPoint(x: personImageView.frame.origin.x + 87, y: 29)
        let size = CGSize(width: 150, height: 19)
        
        let label = UILabel()
        label.text = "\(name) \(surname)"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let origin = CGPoint(x: personImageView.frame.origin.x + 87, y: fullNameLabel.frame.origin.y + 26)
        let size = CGSize(width: 147, height: 30)
        
        let button = UIButton(type: .system, primaryAction: editButtonAction)
        button.frame = CGRect(origin: origin, size: size)
        button.backgroundColor = .backgroundButton
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private lazy var transitionButton: UIButton = {
        let origin = CGPoint(x: editButton.frame.origin.x + 232, y: 47)
        let size = CGSize(width: 17, height: 17)
        
        let button = UIButton(type: .system, primaryAction: transitionButtonAction)
        button.frame = CGRect(origin: origin, size: size)
        button.setImage(.transition, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    // MARK: -  Action
    private lazy var editButtonAction = UIAction { [ weak self ] _ in
        guard let self = self else { return }
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private lazy var transitionButtonAction = UIAction { [ weak self ] _ in
        guard let self = self else { return }
        let profileVC = ProfileViewController()
        profileVC.name = self.name
        profileVC.surname = self.surname
        profileVC.personalInfo = self.personalInfo
        
        self.navigationController?.pushViewController(profileVC, animated: true)
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
    
    private func updateFullNameLabel(name: String, surname: String) {
        fullNameLabel.text = "\(name) \(surname)"
    }
    
    private func updatePersonalInfo(_ info: String) {
        self.personalInfo = info
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


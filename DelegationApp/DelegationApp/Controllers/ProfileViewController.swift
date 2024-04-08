//
//  ProfileViewController.swift
//  DelegationApp
//
//  Created by Matvei Khlestov on 07.04.2024.
//

import UIKit

// MARK: - ProfileViewController
final class ProfileViewController: UIViewController {
    
    // MARK: - Public Properties
    var name = ""
    var surname = ""
    var personalInfo = ""
    
    // MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        createImageView()
    }()
    
    private lazy var fullNameLabel: UILabel = {
        createFullNameLabel()
    }()
    
    private lazy var descriptionLabel: UILabel = {
        createDescriptionLabel()
    }()
    
    private lazy var descriptionTextView: UITextView = {
        createTextView()
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension ProfileViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupNavigationController()
    }
    
    func addSubviews() {
        setupSubviews(
            profileImageView,
            fullNameLabel,
            descriptionLabel,
            descriptionTextView
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationController() {
        title = "\(name) \(surname)"
    }
    
    func createImageView() -> UIImageView {
        let origin = CGPoint(x: 0, y: 145)
        let size = CGSize(width: 75, height: 75)
        
        let imageView = UIImageView()
        imageView.image = .profile
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.frame = CGRect(origin: origin, size: size)
        imageView.center.x = view.center.x
        
        return imageView
    }
    
    func createFullNameLabel() -> UILabel {
        let origin = CGPoint(x: 0, y: profileImageView.frame.origin.y + 98)
        let size = CGSize(width: 150, height: 19)
        
        let label = UILabel()
        label.text = "\(name) \(surname)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(origin: origin, size: size)
        label.center.x = view.center.x
        
        return label
    }
    
    func createDescriptionLabel() -> UILabel {
        let origin = CGPoint(x: 42, y: fullNameLabel.frame.origin.y + 52)
        let size = CGSize(width: 54, height: 19)
        
        let label = UILabel()
        label.text = "О себе"
        label.textColor = .grayLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.frame = CGRect(origin: origin, size: size)
        
        return label
    }
    
    func createTextView() -> UITextView {
        let origin = CGPoint(x: 30, y: descriptionLabel.frame.origin.y + 28)
        let size = CGSize(width: view.frame.width - 60, height: 158)
        
        let textView = UITextView()
        textView.text = personalInfo
        textView.font = .systemFont(ofSize: 16)
        textView.contentInset = UIEdgeInsets(top: 22, left: 12, bottom: 22, right: 15)
        textView.backgroundColor = .backgroundView
        textView.frame = CGRect(origin: origin, size: size)
        textView.layer.cornerRadius = 20
        
        return textView
    }
}

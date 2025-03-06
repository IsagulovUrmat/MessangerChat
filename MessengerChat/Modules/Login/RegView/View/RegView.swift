//
//  RegView.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

protocol RegViewProtocol: AnyObject {
    
}

class RegView: UIViewController, RegViewProtocol {
    
    var presenter: RegViewPresenterProtocol!
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = .localize("regTitleLabel")
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .black)
        return label
    }()
    
    private lazy var nameField: UITextField = TextFeld(fieldPlaceholder: .localize("regNamePlaceholder"))
    private lazy var emailField: UITextField = TextFeld(fieldPlaceholder: "Email")
    private lazy var passField: UITextField = TextFeld(fieldPlaceholder: .localize("passwordPlaceholder"), isPassword: true)
    
    private lazy var regButton: UIButton = Button(buttonText: .localize("regButtonText")) { [weak self] in
        guard let self = self else { return }
        
        let userInfo = UserInfo(email: emailField.text ?? "", password: passField.text ?? "", name: nameField.text ?? "")
        presenter.sendToRegist(userInfo: userInfo)
    }
    
    private lazy var bottomgButton: UIButton = Button(buttonText: .localize("authTitleLabel"), buttonColor: .clear, titleColor: .white) {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.auth])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(pageTitle, nameField, emailField, passField, regButton, bottomgButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nameField.heightAnchor.constraint(equalToConstant: 50),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameField.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -15),
            
            emailField.heightAnchor.constraint(equalToConstant: 50),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            passField.heightAnchor.constraint(equalToConstant: 50),
            passField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            
            regButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 40),
            regButton.heightAnchor.constraint(equalToConstant: 50),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            bottomgButton.heightAnchor.constraint(equalToConstant: 50),
            bottomgButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bottomgButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bottomgButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
        ])
    }
}

//
//  AuthView.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    
}

class AuthView: UIViewController, AuthViewProtocol {
    
    var presenter: AuthViewPresenterProtocol!
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = .localize("authTitleLabel")
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .black)
        return label
    }()
    
    private lazy var emailField: UITextField = TextFeld(fieldPlaceholder: "Email")
    private lazy var passField: UITextField = TextFeld(fieldPlaceholder: .localize("passwordPlaceholder"), isPassword: true)
    
    private lazy var authButton: UIButton = Button(buttonText: .localize("authButtonText")) { [weak self] in
        guard let self = self else { return }
        let userInfo = UserInfo(email: emailField.text ?? "", password: passField.text ?? "")
        presenter.signIn(userInfo: userInfo)
    }
    
    private lazy var regButton: UIButton = Button(buttonText: .localize("regButtonText"), buttonColor: .clear, titleColor: .white) {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.reg])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubviews(pageTitle, emailField, passField, authButton, regButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            emailField.heightAnchor.constraint(equalToConstant: 50),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            passField.heightAnchor.constraint(equalToConstant: 50),
            passField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            
            authButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 40),
            authButton.heightAnchor.constraint(equalToConstant: 50),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            regButton.heightAnchor.constraint(equalToConstant: 50),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            regButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
        ])
    }
}

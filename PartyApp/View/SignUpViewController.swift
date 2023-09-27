//
//  ViewController.swift
//  PartyApp
//
//  Created by Алексей Орловский on 27.09.2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    /// UI Elements
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    private let crearteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDidLoad()
        setupAddSubviews()
        buttonTagrets()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
    }

    func setupAddSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(crearteAccountButton)
    }
    
    func buttonTagrets() {
        crearteAccountButton.addTarget(self, action: #selector(createUserAccountTarget), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        crearteAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
    }
}

/// @objc funcs
extension SignUpViewController {
    
    @objc func createUserAccountTarget() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else { notAllFieldsFull(); return }
        
        
        
        createUserAtFirebase(email: email, password: password)
    }
    
    func createUserAtFirebase(email: String, password: String) {
        
        Firebase.Auth.auth().createUser(withEmail: email, password: password) // completion: )
    }
}

/// Alerts
extension SignUpViewController {
    
    func notAllFieldsFull() {
        let alert = UIAlertController(title: "Field error", message: "Not All field is fielded", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}




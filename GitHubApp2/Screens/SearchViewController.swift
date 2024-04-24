//
//  SearchViewController.swift
//  GitHubApp2
//
//  Created by Amrah on 11.03.24.
//

import UIKit

class SearchViewController: UIViewController {

    let logoImageView = UIImageView()
    let textField = GFTextField()
    let CTA = GFButton(backgroundColor: .systemGreen, title: "Get Follower")
    
    var isusernameEntered: Bool { return !textField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionBtn()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC(){
        
        
        guard isusernameEntered else {
            presentGFAlertOnMainThread(title: "Input is empty", message: "Please write somthing", buttonTitle: "Ok my dear")
            return
        }
        
        let folloerListVC = FollowerListVC()
        folloerListVC.username = textField.text
        folloerListVC.title = textField.text
        navigationController?.pushViewController(folloerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        //Usally there are must 4 constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(textField)
        textField.delegate = self
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureCallToActionBtn(){
        view.addSubview(CTA)
        CTA.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            CTA.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            CTA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            CTA.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            CTA.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
}

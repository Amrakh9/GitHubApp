//
//  GFAlertViewController.swift
//  GitHubApp2
//
//  Created by Amrah on 14.03.24.
//

import UIKit

class GFAlertViewController: UIViewController {

    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let CTA = GFButton(backgroundColor: .systemPink, title: "Aydındır")
    
    var alertTitle: String?
    var alertBody: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.alertBody = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70)
        configureTitleLabel()
        configureContainerView()
        configureButtonLabel()
        configureBodyLabel()
    }
    

    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])

    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went work"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureButtonLabel(){
        containerView.addSubview(CTA)
        CTA.setTitle(buttonTitle ?? "Ok", for: .normal)
        CTA.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            CTA.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            CTA.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            CTA.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            CTA.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureBodyLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = alertBody ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: CTA.topAnchor, constant: -12)
        ])
        
        
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

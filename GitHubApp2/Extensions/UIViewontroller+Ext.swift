//
//  File.swift
//  GitHubApp2
//
//  Created by Amrah on 14.03.24.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async{
            let alerVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alerVC.modalPresentationStyle = .overFullScreen
            alerVC.modalTransitionStyle = .crossDissolve
            self.present(alerVC, animated: true)
        }
    }
    
    //LOADING SCREEN
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityIndicatior = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatior)
        
        activityIndicatior.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatior.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatior.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicatior.startAnimating()
    }
    //Calling Dismiss for Canceling Loading Screen
    func dismissLoadingView(){
        DispatchQueue.main.async{
            containerView.removeFromSuperview()
            containerView = nil
        }
        
    }
    
    //EmptyState View
    func showEmptyStateView(with message: String, in view: UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

 


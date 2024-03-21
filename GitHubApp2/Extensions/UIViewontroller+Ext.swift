//
//  File.swift
//  GitHubApp2
//
//  Created by Amrah on 14.03.24.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async{
            let alerVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alerVC.modalPresentationStyle = .overFullScreen
            alerVC.modalTransitionStyle = .crossDissolve
            self.present(alerVC, animated: true)
        }
    }
}


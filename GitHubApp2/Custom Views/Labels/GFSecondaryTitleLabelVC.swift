//
//  GFSecondaryTitleLabelVC.swift
//  GitHubApp2
//
//  Created by Amrah on 13.04.24.
//

import UIKit

class GFSecondaryTitleLabelVC: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

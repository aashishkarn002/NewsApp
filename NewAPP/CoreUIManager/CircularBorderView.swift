//
//  CircularBorderView.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
import MaterialComponents.MDCCard

@IBDesignable class CircularBorderView: UIView {
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var isCircular: Bool = false {
        didSet {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        
    }
}

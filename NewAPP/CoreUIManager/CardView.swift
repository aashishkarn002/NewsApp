//
//  CardView.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MDCCard
@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}
@IBDesignable class CircularBorderCard: MDCCard {
    
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
    
    @IBInspectable var cornerRadiusT: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadiusT
        }
    }
    
    @IBInspectable var enableShadowElevation: Bool = false {
        didSet {
            if !enableShadowElevation {
                self.setShadowElevation(ShadowElevation(rawValue: 0.0), for: .normal)
                self.setShadowElevation(ShadowElevation(rawValue: 0.0), for: .highlighted)
            }
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
        
        self.inkView.inkColor = #colorLiteral(red: 0.7971922589, green: 0.7971922589, blue: 0.7971922589, alpha: 0.1930918236)
    }
}


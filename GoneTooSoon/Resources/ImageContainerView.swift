//
//  ImageContainerView.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/15/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

@IBDesignable class ImageContainerView: UIView {
    
    // MARK: Variables
    @IBInspectable var borderWidth: Float = 5.0
    @IBInspectable var borderColor: UIColor = UIColor.gray
    @IBInspectable var borderRadius: Float = 18.0
    
    // MARK: Functions
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    func initialize() {
        layer.cornerRadius = CGFloat(borderRadius)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = CGFloat(borderWidth)
    }
}

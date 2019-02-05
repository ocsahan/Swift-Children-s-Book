//
//  RoundImage.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/15/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {
    
    // MARK: Variables
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

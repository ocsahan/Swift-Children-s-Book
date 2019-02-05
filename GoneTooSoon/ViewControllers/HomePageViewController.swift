//
//  HomePageViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/15/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var singleTiger: RoundImage!
    @IBOutlet weak var singlePurple: RoundImage!
    @IBOutlet weak var singleNinja: RoundImage!
    @IBOutlet weak var singleNinjaLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var singleTigerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var singlePurpleLeadingConstraint: NSLayoutConstraint!
    
    // MARK: IBActions
    @IBAction func aboutButtonPressed(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        let aboutView = AboutViewController(nibName: "AboutView", bundle: nil)
        self.navigationController?.pushViewController(aboutView, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        self.singleTiger.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.singlePurple.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.singleNinja.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        self.singleNinjaLeadingConstraint.constant = 60 - 360
        self.singleTigerLeadingConstraint.constant = 220 - 360
        self.singlePurpleLeadingConstraint.constant = 135 - 360
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.singleNinjaLeadingConstraint.constant += 360
        self.singlePurpleLeadingConstraint.constant += 360
        self.singleTigerLeadingConstraint.constant += 360

        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutSubviews()
            
            self.singleTiger.transform = CGAffineTransform(rotationAngle: 0)
            self.singlePurple.transform = CGAffineTransform(rotationAngle: 0)
            self.singleNinja.transform = CGAffineTransform(rotationAngle: 0)
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.singleNinjaLeadingConstraint.constant = 60 - 360
        self.singleTigerLeadingConstraint.constant = 220 - 360
        self.singlePurpleLeadingConstraint.constant = 135 - 360
    }
}


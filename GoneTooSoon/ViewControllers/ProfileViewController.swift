//
//  ProfileViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: Variables
    var parentVC: UIViewController?
    
    // MARK: IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: { [unowned self] in
            self.parentVC!.navigationController?.popViewController(animated: true)})
    }
}

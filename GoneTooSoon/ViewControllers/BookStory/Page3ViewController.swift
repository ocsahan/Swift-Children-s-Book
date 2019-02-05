//
//  Page0ViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import AVFoundation

class Page3ViewController: DataViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var storyText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var collisionFloor: UIView!
    
    // MARK: Variables
    var animator: UIDynamicAnimator!
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let itemBehavior = UIDynamicItemBehavior()
    var beanList = [#imageLiteral(resourceName: "singleNinja"),#imageLiteral(resourceName: "singleTiger"),#imageLiteral(resourceName: "singleLentil"),#imageLiteral(resourceName: "singlePurple")]
    var lastDroppedBean: RoundImage?
    
    // MARK: IBActions
    @IBAction func listenButtonPressed(_ sender: Any) {
        if !synthesizer.isSpeaking {
            startReading()
        }
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        returnToHome()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.delegate = self
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        animator.addBehavior(gravity)
        
        collision.collisionDelegate = self
        collision.addBoundary(withIdentifier: "floor" as NSCopying, for: UIBezierPath(rect: collisionFloor.frame))
        //collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        itemBehavior.elasticity = 0.9
        itemBehavior.friction = 0.1
        
        
        if let customFont = UIFont(name: "ThatPaper", size: 40) {
            attributedString = NSMutableAttributedString(string: storyText.text!,
                                                         attributes: [
                                                            NSAttributedStringKey.font: customFont])
            storyText.attributedText = attributedString
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIViewPropertyAnimator(duration: 3, curve: .easeInOut) { [unowned self] in
            self.backgroundImage.alpha = 0.5
            self.backgroundImage.center.y = self.backgroundImage.center.y + CGFloat(20.0)
            self.backgroundImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }.startAnimation()
    }
    
    // MARK: Functions
    func addProperties(toView view: UIView) {
        gravity.addItem(view)
        collision.addItem(view)
        itemBehavior.addItem(view)
    }
    
    func dropBean() {
        if !beanList.isEmpty {
            let bean = RoundImage(frame: CGRect(x: self.view.frame.midX - 2.0 + CGFloat(beanList.count), y: 100.0, width: 100.0, height: 100.0))
            bean.image = beanList.popLast()
            self.view.addSubview(bean)
            addProperties(toView: bean)
            self.lastDroppedBean = bean
        }
    }
}

// MARK: Extensions
extension Page3ViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        
        if let previousRange = previousRange {
            attributedString.addAttribute(NSAttributedStringKey.backgroundColor,
                                          value: UIColor.clear,
                                          range: previousRange)
        }
        
        attributedString.addAttribute(NSAttributedStringKey.backgroundColor,
                                      value: #colorLiteral(red: 0.968627451, green: 0.8039215686, blue: 0.8431372549, alpha: 1),
                                      range: characterRange)
        storyText.attributedText = attributedString
        previousRange = characterRange
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        if let previousRange = previousRange {
            attributedString.addAttribute(NSAttributedStringKey.backgroundColor,
                                          value: UIColor.clear,
                                          range: previousRange)
            storyText.attributedText = attributedString
            
        }
        
        dropBean()
    }
}

extension Page3ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?,
                           at p: CGPoint) {
        if let identifierString = identifier as? String {
            if identifierString == "floor" {
                if let image = item as? RoundImage {
                    if image == lastDroppedBean {
                        self.dropBean()
                        
                    }
                }
            }
            
        }
    }
}


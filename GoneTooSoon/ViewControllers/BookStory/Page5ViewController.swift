//
//  Page5ViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import AVFoundation

class Page5ViewController: DataViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var singleLentil: RoundImage!
    @IBOutlet weak var singleNinja: RoundImage!
    @IBOutlet weak var singleTiger: RoundImage!
    @IBOutlet weak var singlePurple: RoundImage!
    @IBOutlet weak var chopStick: UIImageView!
    @IBOutlet weak var storyText: UILabel!
    
    // MARK: IBActions
    @IBAction func listenButtonPressed(_ sender: Any) {
        if !synthesizer.isSpeaking {
            startReading()
        }
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        returnToHome()
    }
    
    // MARK: Variables
    var animator: UIDynamicAnimator!
    var snap: UISnapBehavior!
    var attachment: UIAttachmentBehavior!
    var gravity: UIGravityBehavior!
    var beans: [RoundImage]!
    var beanHeld: RoundImage?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beans = [singleLentil, singleNinja, singleTiger, singlePurple]
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveChopstick(_:)))
        chopStick.addGestureRecognizer(gestureRecognizer)
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        animator.addBehavior(gravity)
        
        super.viewDidLoad()
        synthesizer.delegate = self
        
        
        if let customFont = UIFont(name: "ThatPaper", size: 40) {
            attributedString = NSMutableAttributedString(string: storyText.text!,
                                                         attributes: [
                                                            NSAttributedStringKey.font: customFont])
            storyText.attributedText = attributedString
        }
    }
    
    // MARK: Functions
    func snapBean(_ bean: RoundImage) {
        beanHeld = bean
        snap = UISnapBehavior(item: bean, snapTo: CGPoint(x: chopStick.frame.minX + 90.0, y: chopStick.frame.maxY - 70.0))
        animator.addBehavior(snap)
        animator.removeBehavior(snap)
    }
    
    @objc func moveChopstick(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            if let bean = beanHeld {
                bean.center = CGPoint(x: chopStick.frame.minX + 90.0, y: chopStick.frame.maxY - 70.0)
            }
            
        }
        
        switch recognizer.state {
        case .changed:
            for bean in beans {
                let windowRect = self.view.window?.convert(bean.frame, from: bean.superview)
                if windowRect!.contains(recognizer.location(in: self.view)) {
                    if beanHeld == nil {
                        snapBean(bean)
                    }
                }
            }
        default:
            if let bean = beanHeld {
                gravity.addItem(bean)
                beanHeld = nil
            }
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
    }
}

// MARK: Extensions
extension Page5ViewController: AVSpeechSynthesizerDelegate {
    
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
    }
}


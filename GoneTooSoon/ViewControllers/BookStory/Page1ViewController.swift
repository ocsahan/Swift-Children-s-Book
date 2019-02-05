//
//  Page1ViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import AVFoundation

class Page1ViewController: DataViewController {
    
    // MARK: IBActions
    @IBAction func listenButtonPressed(_ sender: Any) {
        if !synthesizer.isSpeaking {
            startReading()
        }
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        returnToHome()
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var darkLayer: UIView!
    @IBOutlet weak var storyText: UILabel!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizer.delegate = self
        
        
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
            self.darkLayer.alpha = 1.0
            self.darkLayer.alpha = 0.5
            }.startAnimation()
    }
}

// MARK: Extensions
extension Page1ViewController: AVSpeechSynthesizerDelegate {
    
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


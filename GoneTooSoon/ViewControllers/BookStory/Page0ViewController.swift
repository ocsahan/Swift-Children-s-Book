//
//  Page0ViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class Page0ViewController: DataViewController {
    
    // MARK: IBActions
    @IBAction func listenButtonPressed(_ sender: Any) {
        if !synthesizer.isSpeaking {
            startReading()
        }
    }
    
    @IBAction func thunderButtonPressed(_ sender: Any) {
        SoundCenter.shared.playThunder()
        let viewAlphaAnimator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0,
                                                                               delay: 0.0,
                                                                               options: [.curveLinear,.repeat],
                                                                               animations: { [unowned self] in
                                                                                UIView.setAnimationRepeatCount(3)
                                                                                self.darkLayer.backgroundColor = .white
                                                                                self.darkLayer.backgroundColor = .black
                                                                                })
        viewAlphaAnimator.startAnimation()
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
        darkLayer.layer.opacity = 0.5
    }  
}

// MARK: Extensions
extension Page0ViewController: AVSpeechSynthesizerDelegate {
    
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


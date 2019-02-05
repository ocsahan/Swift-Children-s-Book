//
//  DataViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/15/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import AVFoundation

class DataViewController: UIViewController {
    
    // MARK: Varibales
    var rootVC: UIViewController!
    var pageNumber = Int()
    let synthesizer = AVSpeechSynthesizer()
    var attributedString = NSMutableAttributedString()
    var previousRange: NSRange?
    
    // MARK: Lifecycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        synthesizer.stopSpeaking(at: .word)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let readToMe = defaults.value(forKey: "readToMe") as! Bool
        if readToMe {
            startReading()
        }
    }
    
    // MARK: Functions
    func startReading() {
        let voice = AVSpeechSynthesisVoice(language: "en_US")
        let utterance = AVSpeechUtterance(string: attributedString.string)
        utterance.voice = voice
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.40
        synthesizer.speak(utterance)
    }
    
    func returnToHome() {
            self.rootVC!.navigationController?.popViewController(animated: false)
    }
}


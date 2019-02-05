//
//  SoundCenter.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundCenter {
    static let shared = SoundCenter()
    
    fileprivate init() {}
    
    func playFire() {
        let fireURL = Bundle.main.url(forResource: "fire", withExtension: "wav")!
        var fire: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(fireURL as CFURL, &fire)
        AudioServicesPlaySystemSound(fire)
    }
    
    func playThunder() {
        let thunderURL = Bundle.main.url(forResource: "thunder", withExtension: "wav")!
        var thunder: SystemSoundID = 1
        AudioServicesCreateSystemSoundID(thunderURL as CFURL, &thunder)
        AudioServicesPlaySystemSound(thunder)
    }
    
    
}

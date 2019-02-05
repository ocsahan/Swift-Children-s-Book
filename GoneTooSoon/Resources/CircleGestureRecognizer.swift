//
//  CircleGestureRecognizer.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/15/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

// Attribution: https://www.raywenderlich.com/104744/uigesturerecognizer-tutorial-creating-custom-recognizers
class CircleGestureRecognizer: UIGestureRecognizer {
    
    // MARK: Variables
    var touchedPoints = [CGPoint]()
    var fittedCenter = CGPoint()
    var tolerance: CGFloat = 0.2
    
    // MARK: Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.reset()
        touchedPoints.removeAll(keepingCapacity: true)
        state = .possible
        
        super.touchesBegan(touches, with: event)
        if touches.count != 1 {
            state = .failed
        }
        state = .began
        
        let window = view?.window
        if let loc = touches.first?.location(in: window) {
            touchedPoints.append(loc)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        if let fittedCircleCenter = getFittedCircleOrigin(points: touchedPoints) {
            state = .ended
            fittedCenter = fittedCircleCenter
        }
        else {
            state = .failed
        }
        super.reset()
        touchedPoints.removeAll(keepingCapacity: true)
        state = .possible
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .failed {
            return
        }
        
        let window = view?.window
        if let loc = touches.first?.location(in: window) {
            touchedPoints.append(loc)
            state = .changed
        }
    }
    
    func getDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(pow(to.x - from.x, 2) + pow(to.y - from.y, 2))
    }
    
    func getFittedCircleOrigin(points: [CGPoint]) -> CGPoint? {
        let firstX = points.first!.x
        let firstY = points.first!.y
        let oppositeX = points[points.count/2].x
        let oppositeY = points[points.count/2].y
        
        let center = CGPoint(x: (firstX + oppositeX)/2.0, y: (firstY + oppositeY)/2.0)
        let radius = getDistance(from: points.first!, to: center)
        let tolerance = radius/1.5
        
        for point in points {
            let distance = getDistance(from: point, to: center)
            if  (distance > radius + tolerance) || (distance < radius - tolerance) {
                return nil
            }
        }
        return center
    }
}

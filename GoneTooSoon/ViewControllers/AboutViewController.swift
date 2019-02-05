//
//  AboutViewController.swift
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/15/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//
enum parentalGateError: Error {
    case wrongIconCircled
}

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var containerLeftTop: ImageContainerView!
    @IBOutlet weak var containerRightTop: ImageContainerView!
    @IBOutlet weak var containerLeftBottom: ImageContainerView!
    @IBOutlet weak var containerRightBottom: ImageContainerView!
    
    // MARK: Variables
    var containers = [UIView]()
    var circleRecognizer: CircleGestureRecognizer!
    var drawingView: UIImageView!
    var lastPoint: CGPoint!
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var drawing = false
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView = UIImageView(frame: self.view.frame)
        drawingView.isUserInteractionEnabled = true
        self.view.addSubview(drawingView)
        containers = [containerLeftTop, containerRightTop, containerLeftBottom, containerRightBottom]
        
        circleRecognizer = CircleGestureRecognizer(target: self, action: #selector(circled))
        view.addGestureRecognizer(circleRecognizer)
    }
    
    // MARK: Functions
    func validateCircle(view: UIView) throws {
        if view == containerLeftTop {
            view.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.631372549, blue: 0.2392156863, alpha: 1)
            let profile = ProfileViewController(nibName: "ProfileView", bundle: nil)
            profile.parentVC = self
            profile.modalPresentationStyle = .formSheet
            let pc = profile.presentationController
            pc?.delegate = self
            self.present(profile, animated: true, completion: nil)
        }
        else { throw parentalGateError.wrongIconCircled }
    }
    
    @objc func circled(_ recognizer: CircleGestureRecognizer) {
        if recognizer.state == .ended {
            if !drawing {
                drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
            }
            drawingView.image = nil
            
            let center = recognizer.fittedCenter
            for view in containers {
                let windowRect = self.view.window?.convert(view.frame, from: view.superview)
                if windowRect!.contains(center) {
                    do { try validateCircle(view: view) }
                    catch
                    {
                        let originalColor = view.backgroundColor
                        UIView.animate(withDuration: 2, animations: {
                            view.backgroundColor = .red
                            view.alpha = 0.25
                            view.alpha = 1
                            view.backgroundColor = originalColor
                        })
                    }
                }
            }
        }
        else if recognizer.state == .began {
            drawing = false
            if let touch = recognizer.touchedPoints.first {
                lastPoint = touch
            }
        }
        else if recognizer.state == .changed {
            drawing = true
            if let touch = recognizer.touchedPoints.last {
                let currentPoint = touch
                drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
        }
        else {
            drawingView.image = nil
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // Create the canvas
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        drawingView.image?.draw(in: CGRect(x: 0, y: 0,
                                           width: view.frame.size.width,
                                           height: view.frame.size.height))
        
        // Create line segment
        context!.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context!.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // Set the `pen`
        context!.setLineCap(.round)
        context!.setLineWidth(brushWidth)
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setBlendMode(.normal)
        
        // Stroke the path with the pen
        context!.strokePath()
        
        // Copy the canvas on the imageview
        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        drawingView.alpha = opacity
        UIGraphicsEndImageContext()
    }
}

// MARK: Extensions
extension AboutViewController: UIAdaptivePresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

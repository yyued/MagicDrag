//
//  MGDAnimateImageView.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class MGDAnimateImageView: UIImageView, MGDAnimatable, MGDAnimationFade, MGDAnimationMove, MGDAnimationZoom {
    
    @IBInspectable var delaysOfAnimation: CGFloat = 0.0
    @IBInspectable var numbersOfPower: CGFloat = 3.0
    
    @IBInspectable var fadeIn: Bool = false
    @IBInspectable var fadeOut: Bool = false
    
    @IBInspectable var moveIn: CGPoint = CGPoint.zero
    @IBInspectable var moveOut: CGPoint = CGPoint.zero
    
    @IBInspectable var zoomIn: CGPoint = CGPoint(x: 1.0, y: 1.0)
    @IBInspectable var zoomOut: CGPoint = CGPoint(x: 1.0, y: 1.0)
    
    func layerAnimation(viewProgress: CGFloat) {
        if fadeIn {
            MGDAnimator.fadeIn(self, viewProgress: viewProgress)
        }
        if fadeOut {
            MGDAnimator.fadeOut(self, viewProgress: viewProgress)
        }
        if moveIn != CGPoint.zero {
            MGDAnimator.moveIn(self, from: moveIn, viewProgress: viewProgress)
        }
        if moveOut != CGPoint.zero {
            MGDAnimator.moveOut(self, to: moveOut, viewProgress: viewProgress)
        }
        if zoomIn != CGPoint(x: 1.0, y: 1.0) {
            MGDAnimator.zoomIn(self, from: zoomIn, viewProgress: viewProgress)
        }
        if zoomOut != CGPoint(x: 1.0, y: 1.0) {
            MGDAnimator.zoomOut(self, to: zoomOut, viewProgress: viewProgress)
        }
    }
    
}

//
//  MGDAnimateLabel.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class MGDAnimateLabel: UILabel, MGDAnimatable, MGDAnimationFade, MGDAnimationMove {
    
    @IBInspectable var delaysOfAnimation: CGFloat = 0.0
    
    @IBInspectable var fadeIn: Bool = false
    @IBInspectable var fadeOut: Bool = false
    
    @IBInspectable var moveIn: CGPoint = CGPoint.zero
    @IBInspectable var moveOut: CGPoint = CGPoint.zero
    
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
    }
    
}

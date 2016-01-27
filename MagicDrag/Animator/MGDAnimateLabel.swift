//
//  MGDAnimateLabel.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class MGDAnimateLabel: UILabel, MGDAnimatable, MGDAnimationFade {
    
    @IBInspectable var fadeIn: Bool = false
    @IBInspectable var fadeOut: Bool = false
    
    func layerAnimation(viewProgress: CGFloat) {
        if fadeIn {
            MGDAnimator.fadeIn(self, viewProgress: viewProgress)
        }
        if fadeOut {
            MGDAnimator.fadeOut(self, viewProgress: viewProgress)
        }
    }
    
}

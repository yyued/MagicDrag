//
//  MGDAnimator.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

protocol MGDAnimatable {
    
    func layerAnimation(viewProgress: CGFloat)
    
}

protocol MGDAnimationFade {
    
    var fadeIn: Bool { get set }
    var fadeOut: Bool { get set }
    
}

class MGDAnimator {
    
    static func fadeIn(item: UIView, viewProgress: CGFloat) {
        if viewProgress <= -1.0 {
            item.alpha = 0.0
        }
        else if viewProgress <= 0.0 {
            item.alpha = 1.0 + viewProgress
        }
    }
    
    static func fadeOut(item: UIView, viewProgress: CGFloat) {
        if viewProgress >= 1.0 {
            item.alpha = 0.0
        }
        else if viewProgress >= 0.0 {
            item.alpha = 1.0 - viewProgress
        }
    }
    
}
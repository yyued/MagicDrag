//
//  MGDAnimator.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

protocol MGDAnimatable {
    
    var delaysOfAnimation: CGFloat { get set }
    
    func layerAnimation(viewProgress: CGFloat)
    
}

protocol MGDAnimationFade {
    
    var fadeIn: Bool { get set }
    var fadeOut: Bool { get set }
    
}

class MGDAnimator {
    
    static func delayProgress(item: UIView, viewProgress: CGFloat) -> CGFloat? {
        if let item = item as? MGDAnimatable {
            if item.delaysOfAnimation > 0.0 && item.delaysOfAnimation < 1.0 {
                if viewProgress < 0.0 && 1.0 - fabs(viewProgress) < item.delaysOfAnimation {
                    return nil
                }
                else if viewProgress > 0.0 && viewProgress < item.delaysOfAnimation {
                    return nil
                }
                else {
                    return item.delaysOfAnimation
                }
            }
        }
        return 0.0
    }
    
    static func fadeIn(item: UIView, viewProgress: CGFloat) {
        if viewProgress <= -1.0 {
            item.alpha = 0.0
        }
        else if viewProgress <= 0.0 {
            guard let delayProgress = self.delayProgress(item, viewProgress: viewProgress) else {
                item.alpha = 0.0
                return
            }
            item.alpha = 1.0 + viewProgress * 1.0 / (1.0 - delayProgress)
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
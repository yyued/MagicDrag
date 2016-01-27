//
//  MGDAnimations.swift
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
    
}

func animatingFadeView(item: UIView, viewProgress: CGFloat) {
    if viewProgress <= -1.0 {
        item.alpha = 0.0
    }
    else if viewProgress <= 0.0 {
        item.alpha = 1.0 + viewProgress
    }
}

class MGDAnimationView: UIView, MGDAnimatable, MGDAnimationFade {
    
    @IBInspectable var fadeIn: Bool = false
    
    func layerAnimation(viewProgress: CGFloat) {
        if fadeIn {
            animatingFadeView(self, viewProgress: viewProgress)
        }
    }
    
}

class MGDAnimationLabel: UILabel, MGDAnimatable, MGDAnimationFade {
    
    @IBInspectable var fadeIn: Bool = false
    
    func layerAnimation(viewProgress: CGFloat) {
        if fadeIn {
            animatingFadeView(self, viewProgress: viewProgress)
        }
    }
    
}

class MGDAnimationImageView: UIImageView, MGDAnimatable, MGDAnimationFade {
    
    @IBInspectable var fadeIn: Bool = false
    
    func layerAnimation(viewProgress: CGFloat) {
        if fadeIn {
            animatingFadeView(self, viewProgress: viewProgress)
        }
    }
    
}

class MGDAnimationButton: UIButton, MGDAnimatable, MGDAnimationFade {
    
    @IBInspectable var fadeIn: Bool = false
    
    func layerAnimation(viewProgress: CGFloat) {
        if fadeIn {
            animatingFadeView(self, viewProgress: viewProgress)
        }
    }
    
}

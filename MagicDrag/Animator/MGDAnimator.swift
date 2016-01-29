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
    var numbersOfPower: CGFloat { get set }
    
    func layerAnimation(viewProgress: CGFloat)
    
}

protocol MGDTouchable {
    
    var canTouch: Bool { get set }
    
}

protocol MGDAnimationFade {
    
    var fadeIn: Bool { get set }
    var fadeOut: Bool { get set }
    
}

protocol MGDAnimationMove {
    
    var moveIn: CGPoint { get set }
    var moveOut: CGPoint { get set }
    
}

protocol MGDAnimationZoom {
    
    var zoomIn: CGPoint { get set }
    var zoomOut: CGPoint { get set }
    
}

class MGDAnimator {
    
    static func fadeIn(item: UIView, viewProgress: CGFloat) {
        let calculatedProgress = self.delayProgress(item, viewProgress: viewProgress) ?? viewProgress
        let numbersOfPower: CGFloat = {
            return (item as! MGDAnimatable).numbersOfPower
        }()
        if let alpha = self.inValue(0.0, toValue: 1.0, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
            item.alpha = alpha
        }
    }
    
    static func fadeOut(item: UIView, viewProgress: CGFloat) {
        let calculatedProgress = self.delayProgress(item, viewProgress: viewProgress) ?? viewProgress
        let numbersOfPower: CGFloat = {
            return (item as! MGDAnimatable).numbersOfPower
        }()
        if let alpha = self.outValue(1.0, toValue: 0.0, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
            item.alpha = alpha
        }
    }
    
    static func moveIn(item: UIView, from: CGPoint, viewProgress: CGFloat) {
        let calculatedProgress = self.delayProgress(item, viewProgress: viewProgress) ?? viewProgress
        let numbersOfPower: CGFloat = {
            return (item as! MGDAnimatable).numbersOfPower
        }()
        if let constraint = item.xConstraint, let origin = constraint.MGD_originConstant {
            if let value = self.inValue(origin + from.x, toValue: origin, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
                constraint.constant = value
            }
        }
        if let constraint = item.yConstraint, let origin = constraint.MGD_originConstant {
            if let value = self.inValue(origin + from.y, toValue: origin, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
                constraint.constant = value
            }
        }
    }
    
    static func moveOut(item: UIView, to: CGPoint, viewProgress: CGFloat) {
        let calculatedProgress = self.delayProgress(item, viewProgress: viewProgress) ?? viewProgress
        let numbersOfPower: CGFloat = {
            return (item as! MGDAnimatable).numbersOfPower
        }()
        if let constraint = item.xConstraint, let origin = constraint.MGD_originConstant {
            if let value = self.outValue(origin, toValue: origin + to.x, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
                constraint.constant = value
            }
        }
        if let constraint = item.yConstraint, let origin = constraint.MGD_originConstant {
            if let value = self.outValue(origin, toValue: origin + to.y, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
                constraint.constant = value
            }
        }
    }
    
    static func zoomIn(item: UIView, from: CGPoint, viewProgress: CGFloat) {
        let calculatedProgress = self.delayProgress(item, viewProgress: viewProgress) ?? viewProgress
        let numbersOfPower: CGFloat = {
            return (item as! MGDAnimatable).numbersOfPower
        }()
        if let x = self.inValue(from.x, toValue: 1.0, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower),
           let y = self.inValue(from.y, toValue: 1.0, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
            item.transform = CGAffineTransformMakeScale(x, y)
        }
    }
    
    static func zoomOut(item: UIView, to: CGPoint, viewProgress: CGFloat) {
        let calculatedProgress = self.delayProgress(item, viewProgress: viewProgress) ?? viewProgress
        let numbersOfPower: CGFloat = {
            return (item as! MGDAnimatable).numbersOfPower
        }()
        if let x = self.outValue(1.0, toValue: to.x, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower),
            let y = self.outValue(1.0, toValue: to.y, viewProgress: calculatedProgress, numbersOfPower: numbersOfPower) {
                item.transform = CGAffineTransformMakeScale(x, y)
        }
    }
    
}

extension MGDAnimator {
    
    static func delayProgress(item: UIView, viewProgress: CGFloat) -> CGFloat? {
        if let item = item as? MGDAnimatable {
            if item.delaysOfAnimation > 0.0 {
                let absViewProgress = viewProgress < 0.0 ? 1.0 + viewProgress : viewProgress
                if item.delaysOfAnimation > absViewProgress {
                    if viewProgress < 0.0 {
                        return -1.0
                    }
                    else {
                        return 0.0
                    }
                }
                else {
                    let absDelayProgress = (1.0 / (1.0 - item.delaysOfAnimation)) * absViewProgress + (-item.delaysOfAnimation / (1.0 - item.delaysOfAnimation))
                    if viewProgress < 0.0 {
                        return absDelayProgress - 1.0
                    }
                    else {
                        return absDelayProgress
                    }
                }
            }
        }
        return nil
    }
    
    static func powerProgress(viewProgress: CGFloat, numbersOfPower: CGFloat) -> CGFloat {
        return pow(viewProgress, numbersOfPower)
    }
    
    static func inValue(fromValue: CGFloat, toValue: CGFloat, viewProgress: CGFloat, numbersOfPower: CGFloat = 3.0) -> CGFloat? {
        if viewProgress <= -1.0 {
            return fromValue
        }
        else if viewProgress <= 0.0 {
            let viewProgress = viewProgress + 1.0
            return fromValue + (toValue - fromValue) * viewProgress * viewProgress
        }
        else {
            return nil
        }
    }
    
    static func outValue(fromValue: CGFloat, toValue: CGFloat, viewProgress: CGFloat, numbersOfPower: CGFloat = 3.0) -> CGFloat? {
        if viewProgress >= 1.0 {
            return toValue
        }
        else if viewProgress >= 0.0 {
            return fromValue + (toValue - fromValue) * viewProgress * viewProgress
        }
        else {
            return nil
        }
    }
    
}
//
//  MGDLayoutConstraint.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

private var MGD_originConstantKey: UInt16 = 0

extension NSLayoutConstraint {
    
    var MGD_originConstant: CGFloat? {
        set {
            objc_setAssociatedObject(self, &MGD_originConstantKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &MGD_originConstantKey) as? CGFloat {
                return value
            }
            return nil
        }
    }
    
}

extension UIView {
    
    var xConstraint: NSLayoutConstraint? {
        if let superView = self.superview {
            for constraint in superView.constraints {
                if (constraint.firstItem as! NSObject == self || constraint.secondItem as! NSObject  == self)
                    && constraint.identifier == "X" {
                        if constraint.MGD_originConstant == nil {
                            constraint.MGD_originConstant = constraint.constant
                        }
                        return constraint
                }
            }
        }
        return nil
    }
    
    var yConstraint: NSLayoutConstraint? {
        if let superView = self.superview {
            for constraint in superView.constraints {
                if (constraint.firstItem as! NSObject == self || constraint.secondItem as! NSObject  == self)
                    && constraint.identifier == "Y" {
                        if constraint.MGD_originConstant == nil {
                            constraint.MGD_originConstant = constraint.constant
                        }
                        return constraint
                }
            }
        }
        return nil
    }
    
    var wConstraint: NSLayoutConstraint? {
        for constraint in self.constraints {
            if constraint.identifier == "W" {
                if constraint.MGD_originConstant == nil {
                    constraint.MGD_originConstant = constraint.constant
                }
                return constraint
            }
        }
        return nil
    }
    
    var hConstraint: NSLayoutConstraint? {
        for constraint in self.constraints {
            if constraint.identifier == "H" {
                if constraint.MGD_originConstant == nil {
                    constraint.MGD_originConstant = constraint.constant
                }
                return constraint
            }
        }
        return nil
    }
    
}

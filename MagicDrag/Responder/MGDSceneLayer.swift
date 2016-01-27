//
//  MGDLayerView.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

/**
 * 图层类
 */
class MGDSceneLayer: UIView {

    /**
     * 图层顺层，数值越小，层级越低。
     */
    @IBInspectable var layerIndex: Int = 0
    
    /**
     * stream 跟随滚动条移动
     * push   跟随滚动条推进
     * fix    固定在首屏
     */
    @IBInspectable var layerStyle: String = "stream" // stream/push/fix
    
    /**
     * Private
     */
    var layerAtPage: Int = 0
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        for subview in self.subviews {
            if let subview = subview as? MGDAnimatable {
                subview.layerAnimation(-1.0)
            }
        }
    }
    
    /**
     * 用于页面推进的同时，图层对应控件相应的变化。
     * viewProgress = [-1,1]
     * 例如本页是 B
     * [-1,0) A -> B
     * == 0   A - [B] - C
     * (0,1]  B -> C
     */
    func layerAnimation(viewProgress: CGFloat) {
        for subview in self.subviews {
            if let subview = subview as? MGDAnimatable {
                subview.layerAnimation(viewProgress)
            }
        }
    }

}

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

}

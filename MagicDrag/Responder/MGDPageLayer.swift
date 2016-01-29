//
//  MGDPageLayer.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class MGDPageLayer: UIView {
    
    var sceneLayerMap: [Int: MGDSceneLayer] = [:]
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        for sceneLayer in self.subviews {
            for animateView in sceneLayer.subviews {
                if let touchableView = animateView as? MGDTouchable where touchableView.canTouch {
                    let innerPoint = animateView.convertPoint(point, fromView: sceneLayer)
                    if animateView.alpha > 0.0 && animateView.pointInside(innerPoint, withEvent: event) {
                        return animateView
                    }
                }
            }
        }
        return nil
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.autoresizingMask = []
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func newLayer(style: String) -> MGDPageLayer? {
        if style == "stream" {
            return MGDStreamPageLayer()
        }
        else if style == "push" {
            return MGDPushPageLayer()
        }
        else if style == "fix" {
            return MGDFixPageLayer()
        }
        return nil
    }
    
    func addSceneLayer(sceneLayer: MGDSceneLayer, atPage: Int) {
        sceneLayer.layerAtPage = atPage
        sceneLayerMap[atPage] = sceneLayer
    }
    
    func scrolling(contentOffsetX: CGFloat) {
        let currentPage = Int(contentOffsetX / UIScreen.mainScreen().bounds.size.width)
        let lastPage = currentPage - 1
        let nextPage = currentPage + 1
        if let sceneLayer = sceneLayerMap[lastPage] {
            sceneLayer.layerAnimation(1.0)
        }
        if let sceneLayer = sceneLayerMap[currentPage] {
            sceneLayer.layerAnimation((contentOffsetX % UIScreen.mainScreen().bounds.size.width) / UIScreen.mainScreen().bounds.size.width)
        }
        if let sceneLayer = sceneLayerMap[nextPage] {
            sceneLayer.layerAnimation((contentOffsetX % UIScreen.mainScreen().bounds.size.width) / UIScreen.mainScreen().bounds.size.width - 1.0)
        }
    }
    
}

class MGDStreamPageLayer: MGDPageLayer {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSceneLayer(sceneLayer: MGDSceneLayer, atPage: Int) {
        sceneLayer.frame = CGRect(
            x: UIScreen.mainScreen().bounds.size.width * CGFloat(atPage),
            y: 0,
            width: UIScreen.mainScreen().bounds.size.width,
            height: UIScreen.mainScreen().bounds.size.height
        )
        sceneLayer.translatesAutoresizingMaskIntoConstraints = true
        sceneLayer.autoresizingMask = []
        addSubview(sceneLayer)
        super.addSceneLayer(sceneLayer, atPage: atPage)
    }
    
    override func scrolling(contentOffsetX: CGFloat) {
        self.frame = {
            var frame = self.frame
            frame.origin.x = -contentOffsetX
            return frame
            }()
        super.scrolling(contentOffsetX)
    }
    
}

class MGDPushPageLayer: MGDPageLayer {
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSceneLayer(sceneLayer: MGDSceneLayer, atPage: Int) {
        sceneLayer.frame = CGRect(
            x: UIScreen.mainScreen().bounds.size.width * CGFloat(atPage > 0 ? 1 : 0),
            y: 0,
            width: UIScreen.mainScreen().bounds.size.width,
            height: UIScreen.mainScreen().bounds.size.height
        )
        sceneLayer.translatesAutoresizingMaskIntoConstraints = true
        sceneLayer.autoresizingMask = []
        addSubview(sceneLayer)
        super.addSceneLayer(sceneLayer, atPage: atPage)
    }
    
    override func scrolling(contentOffsetX: CGFloat) {
        let controlPage = (Int((contentOffsetX + UIScreen.mainScreen().bounds.size.width) / UIScreen.mainScreen().bounds.size.width))
        if controlPage <= 0 {
            return
        }
        if let sceneLayer = sceneLayerMap[controlPage] {
            let sceneOriginX = UIScreen.mainScreen().bounds.size.width - contentOffsetX % UIScreen.mainScreen().bounds.size.width
            sceneLayer.frame = {
                var frame = sceneLayer.frame
                frame.origin.x = sceneOriginX < 1.0 ? 0.0 : sceneOriginX
                return frame
                }()
        }
        let lastPage = controlPage - 1
        if let sceneLayer = sceneLayerMap[lastPage] {
            sceneLayer.frame = {
                var frame = sceneLayer.frame
                frame.origin.x = 0.0
                return frame
                }()
        }
        let nextPage = controlPage + 1
        if let sceneLayer = sceneLayerMap[nextPage] {
            sceneLayer.frame = {
                var frame = sceneLayer.frame
                frame.origin.x = UIScreen.mainScreen().bounds.size.width
                return frame
                }()
        }
        super.scrolling(contentOffsetX)
    }
    
}

class MGDFixPageLayer: MGDPageLayer {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSceneLayer(sceneLayer: MGDSceneLayer, atPage: Int) {
        sceneLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.mainScreen().bounds.size.width,
            height: UIScreen.mainScreen().bounds.size.height
        )
        sceneLayer.translatesAutoresizingMaskIntoConstraints = true
        sceneLayer.autoresizingMask = []
        addSubview(sceneLayer)
        super.addSceneLayer(sceneLayer, atPage: atPage)
    }
    
    override func scrolling(contentOffsetX: CGFloat) {
        super.scrolling(contentOffsetX)
    }
    
}

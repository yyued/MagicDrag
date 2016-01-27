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
        self.userInteractionEnabled = false
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
    }
    
}

class MGDPushPageLayer: MGDPageLayer {
    
    override init() {
        super.init()
        self.userInteractionEnabled = false
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
        super.scrolling(contentOffsetX)
    }
    
}

class MGDFixPageLayer: MGDPageLayer {
    
    override init() {
        super.init()
        self.userInteractionEnabled = false
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

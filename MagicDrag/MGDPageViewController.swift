//
//  MGDPageViewController.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class MGDPageViewController: UIViewController {

    var viewControllers: [MGDSceneViewController] = []
    let scrollView = UIScrollView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureScrollView() {
        self.view.addSubview(scrollView)
        self.view.sendSubviewToBack(scrollView)
        for pageLayer in buildPageLayers() {
            pageLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: UIScreen.mainScreen().bounds.size.width * CGFloat(viewControllers.count),
                height: UIScreen.mainScreen().bounds.size.height
            )
            scrollView.addSubview(pageLayer)
        }
        scrollView.contentSize = CGSize(
            width: UIScreen.mainScreen().bounds.size.width * CGFloat(viewControllers.count),
            height: UIScreen.mainScreen().bounds.size.height)
        scrollView.frame = UIScreen.mainScreen().bounds
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

extension MGDPageViewController {
    
    func buildPageLayers() -> [PageLayer] {
        let pageLayers: [Int: PageLayer] = {
            var tmpPageLayers: [Int: PageLayer] = [:]
            for (idx, viewController) in self.viewControllers.enumerate() {
                for sceneLayer in viewController.layers {
                    if let pageLayer = tmpPageLayers[idx] {
                        pageLayer.addSceneLayer(sceneLayer, atPage: idx)
                    }
                    else if let pageLayer = PageLayer.newLayer(sceneLayer.layerStyle) {
                        tmpPageLayers[idx] = pageLayer
                        pageLayer.addSceneLayer(sceneLayer, atPage: idx)
                    }
                }
            }
            return tmpPageLayers
        }()
        return {
            var tmpLayers: [PageLayer] = []
            let allKeys = pageLayers.keys.sort {
                $0 < $1
            }
            for key in allKeys {
                tmpLayers.append(pageLayers[key]!)
            }
            return tmpLayers
            }()
    }
    
}

extension MGDPageViewController {
    
    class PageLayer: UIView {
        
        init() {
            super.init(frame: CGRect.zero)
            self.translatesAutoresizingMaskIntoConstraints = true
            self.autoresizingMask = []
            self.backgroundColor = UIColor.clearColor()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        static func newLayer(style: String) -> PageLayer? {
            if style == "stream" {
                return StreamPageLayer()
            }
            else if style == "push" {
                return PushPageLayer()
            }
            else if style == "fix" {
                return FixPageLayer()
            }
            return nil
        }
        
        func addSceneLayer(sceneLayer: MGDSceneLayer, atPage: Int) {
            
        }
        
    }
    
    class StreamPageLayer: PageLayer {
        
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
        
    }
    
    class PushPageLayer: PageLayer {
        
    }
    
    class FixPageLayer: PageLayer {
        
    }
    
}
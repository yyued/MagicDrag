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
    
    deinit {
        scrollView.delegate = nil
    }
    
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
            self.view.addSubview(pageLayer)
        }
        scrollView.contentSize = CGSize(
            width: UIScreen.mainScreen().bounds.size.width * CGFloat(viewControllers.count),
            height: UIScreen.mainScreen().bounds.size.height)
        scrollView.frame = UIScreen.mainScreen().bounds
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

extension MGDPageViewController {
    
    func buildPageLayers() -> [MGDPageLayer] {
        let pageLayers: [Int: MGDPageLayer] = {
            var tmpPageLayers: [Int: MGDPageLayer] = [:]
            for (pageIndex, viewController) in self.viewControllers.enumerate() {
                for sceneLayer in viewController.layers {
                    if let pageLayer = tmpPageLayers[sceneLayer.layerIndex] {
                        pageLayer.addSceneLayer(sceneLayer, atPage: pageIndex)
                    }
                    else if let pageLayer = MGDPageLayer.newLayer(sceneLayer.layerStyle) {
                        tmpPageLayers[sceneLayer.layerIndex] = pageLayer
                        pageLayer.addSceneLayer(sceneLayer, atPage: pageIndex)
                    }
                }
            }
            return tmpPageLayers
        }()
        return {
            var tmpLayers: [MGDPageLayer] = []
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

extension MGDPageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for view in scrollView.subviews {
            if let view = view as? MGDPageLayer {
                view.scrolling(scrollView.contentOffset.x)
            }
        }
        for view in self.view.subviews {
            if let view = view as? MGDPageLayer {
                view.scrolling(scrollView.contentOffset.x)
            }
        }
    }
    
}
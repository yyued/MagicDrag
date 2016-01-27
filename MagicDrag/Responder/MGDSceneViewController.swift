//
//  MGDSceneViewController.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class MGDSceneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/// MARK: - Layer
extension MGDSceneViewController {
    
    var layers: [MGDSceneLayer] {
        return self.view.subviews.flatMap({ (aView) -> MGDSceneLayer? in
            if let aView = aView as? MGDSceneLayer {
                return aView
            }
            else {
                return nil
            }
        }).sort({ (aView, bView) -> Bool in
            aView.layerIndex < bView.layerIndex
        })
    }
    
    var layerIndexes: [Int] {
        return self.layers.map({ (layer) -> Int in
            layer.layerIndex
        })
    }
    
}

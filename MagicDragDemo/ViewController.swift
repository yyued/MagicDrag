//
//  ViewController.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/27.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let vc = MGDPageViewController()
        vc.viewControllers = [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Scene_0") as! MGDSceneViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Scene_1") as! MGDSceneViewController,
        ]
        self.presentViewController(vc, animated: false, completion: nil)
    }

}

class DemoLayer: MGDSceneLayer {
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        self.alpha = 0.0
    }
    
    override func layerAnimation(viewProgress: CGFloat) {
        if viewProgress <= 0.0 {
            self.alpha = 1.0 + viewProgress
        }
    }
    
}


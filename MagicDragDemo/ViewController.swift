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
//        self.presentViewController(TeambitionPageViewController(), animated: false, completion: nil)
        self.presentViewController( UIStoryboard(name: "SimpleStart", bundle: nil).instantiateInitialViewController()!,
            animated: false, completion: nil)
    }

}

class DemoLayer: MGDSceneLayer {
    
}

class Demo2Layer: MGDSceneLayer {
    
}


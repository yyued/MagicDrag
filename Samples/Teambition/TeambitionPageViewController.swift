//
//  TeambitionPageViewController.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/28.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class TeambitionPageViewController: MGDPageViewController {

    let storyBoard = UIStoryboard(name: "Teambition", bundle: nil)
    
    override init() {
        super.init()
        self.viewControllers = [
            storyBoard.instantiateViewControllerWithIdentifier("Scene_0") as! MGDSceneViewController,
            storyBoard.instantiateViewControllerWithIdentifier("Scene_1") as! MGDSceneViewController,
            storyBoard.instantiateViewControllerWithIdentifier("Scene_2") as! MGDSceneViewController,
            storyBoard.instantiateViewControllerWithIdentifier("Scene_3") as! MGDSceneViewController,
            storyBoard.instantiateViewControllerWithIdentifier("Scene_4") as! MGDSceneViewController,
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
}

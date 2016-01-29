//
//  SimpleStartAnimatedBallViewController.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/29.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class SimpleStartAnimatedBallViewController: MGDSceneViewController {

    @IBAction func handleDirectorTapped(sender: AnyObject) {
        UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }

}

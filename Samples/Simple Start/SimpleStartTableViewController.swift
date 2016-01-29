//
//  SimpleStartTableViewController.swift
//  MagicDrag
//
//  Created by 崔 明辉 on 16/1/29.
//  Copyright © 2016年 swift. All rights reserved.
//

import UIKit

class SimpleStartTableViewController: UITableViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let storyBoard = UIStoryboard(name: "SimpleStart_StreamLayer", bundle: nil)
            let viewControllers = [
                storyBoard.instantiateViewControllerWithIdentifier("Classical_0"),
                storyBoard.instantiateViewControllerWithIdentifier("Classical_1"),
                storyBoard.instantiateViewControllerWithIdentifier("Classical_2"),
            ]
            if let viewControllers = viewControllers as? [MGDSceneViewController] {
                let pageViewController = SimpleStartPageViewController()
                pageViewController.viewControllers = viewControllers
                self.presentViewController(pageViewController, animated: false, completion: nil)
            }
        }
        else if indexPath.row == 1 {
            let storyBoard = UIStoryboard(name: "SimpleStart_PushLayer", bundle: nil)
            let viewControllers = [
                storyBoard.instantiateViewControllerWithIdentifier("Push_0"),
                storyBoard.instantiateViewControllerWithIdentifier("Push_1"),
                storyBoard.instantiateViewControllerWithIdentifier("Push_2"),
            ]
            if let viewControllers = viewControllers as? [MGDSceneViewController] {
                let pageViewController = SimpleStartPageViewController()
                pageViewController.viewControllers = viewControllers
                self.presentViewController(pageViewController, animated: false, completion: nil)
            }
        }
        else if indexPath.row == 2 {
            let storyBoard = UIStoryboard(name: "SimpleStart_FixLayer", bundle: nil)
            let viewControllers = [
                storyBoard.instantiateViewControllerWithIdentifier("Fix_0"),
                storyBoard.instantiateViewControllerWithIdentifier("Fix_1"),
                storyBoard.instantiateViewControllerWithIdentifier("Fix_2"),
            ]
            if let viewControllers = viewControllers as? [MGDSceneViewController] {
                let pageViewController = SimpleStartPageViewController()
                pageViewController.viewControllers = viewControllers
                self.presentViewController(pageViewController, animated: false, completion: nil)
            }
        }
    }

}

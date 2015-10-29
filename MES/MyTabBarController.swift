//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by Han_Luo on 29/06/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return nil
    }
}
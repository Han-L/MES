//
//  MainViewController.swift
//  QRCodeReader
//
//  Created by Han_Luo on 08/09/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
      
    // MARK: - navigation 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? UINavigationController {
            if let controller = nvc.visibleViewController as? PersonalInformationTableViewController {
                if segue.identifier == "visitorMode" {
                    controller.visitorModeOn = true
                }
            }
        }
        
        if let nvc1 = segue.destinationViewController as? UINavigationController {
            if let vc = nvc1.visibleViewController as? QRCodeReadingViewController {
                vc.title = "请扫描职员二维码"
                if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
                    actionControllerForCheckingCamera()
                }

            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // Action Controller
    func actionControllerForCheckingCamera() {
        let alert = UIAlertController(title: "提示", message: "没有摄像头或摄像头不可用", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "确认", style: .Default, handler: nil)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
}

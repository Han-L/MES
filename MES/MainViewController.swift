//
//  MainViewController.swift
//  QRCodeReader
//
//  Created by Han_Luo on 08/09/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var visitorButton: UIButton!
    @IBOutlet weak var iconPic: UIImageView!
    
    @IBOutlet weak var upperConstraint: NSLayoutConstraint!
    @IBOutlet weak var lowerConstraint: NSLayoutConstraint!
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upperConstraint.constant = self.view.bounds.size.height / 24
        middleConstraint.constant = self.view.bounds.size.height / 25
        lowerConstraint.constant = self.view.bounds.size.height / 20
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        codeButton.center.y += view.bounds.height
        visitorButton.center.y += view.bounds.height
        iconPic.alpha = 0
        codeButton.alpha = 0
        visitorButton.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {self.codeButton.center.y -= self.view.bounds.height}, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {self.visitorButton.center.y -= self.view.bounds.height}, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveLinear, animations: {self.iconPic.alpha = 1}, completion: nil)
        UIView.animateWithDuration(1, animations: {self.codeButton.alpha = 1; self.visitorButton.alpha = 1})

    }
    
    
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

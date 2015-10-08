//
//  MainViewController.swift
//  QRCodeReader
//
//  Created by Han_Luo on 08/09/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func exit(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? UINavigationController {
            if let controller = nvc.visibleViewController as? PersonalInformationTableViewController {
                if segue.identifier == "visitorMode" {
                    controller.idNumber = "访客"
                }
            }
        }
    }
}

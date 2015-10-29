//
//  LogoutViewController.swift
//  MES
//
//  Created by Han_Luo on 16/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit

class LogoutTableViewController: UITableViewController {

    @IBOutlet weak var staffName: UILabel!
    @IBOutlet weak var productName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        staffName.text = staff.name
        
        if card.cardSerial != nil {
            productName.text = card.cardType! + ", " + card.cardSerial! + ", " + card.manName! + ", " + card.productionBatch!
        } else {
            productName.text = "暂无扫描产品"
        }

    }
    
      
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 1 {
            productName.text = "暂无扫描产品"
            
            resetCard()
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            let myStoryBoard = self.storyboard
            let mainVC = myStoryBoard!.instantiateViewControllerWithIdentifier("main")
            mainVC.modalTransitionStyle = .CrossDissolve
            self.presentViewController(mainVC, animated: true, completion: nil)
            
            resetStaff()
        }
    }
}

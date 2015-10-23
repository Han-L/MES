//
//  LogoutViewController.swift
//  MES
//
//  Created by Han_Luo on 16/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit

class LogoutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = staff.name
    }


    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 1 {
            let myStoryBoard = self.storyboard
            let mainVC = myStoryBoard!.instantiateViewControllerWithIdentifier("main")
            mainVC.modalTransitionStyle = .CrossDissolve
            self.presentViewController(mainVC, animated: true, completion: nil)
            
            
            resetStaff()
            resetCard()
        }
    }
    
    
}

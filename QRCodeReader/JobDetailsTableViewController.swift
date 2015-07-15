//
//  JobDetailsTableViewController.swift
//  QRCodeReader
//
//  Created by Han_Luo on 14/07/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class JobDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var outputDigit: String?
    
    @IBAction func rescan(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = outputDigit
    }

}

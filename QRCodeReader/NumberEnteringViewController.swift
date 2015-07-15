//
//  NumberEnteringViewController.swift
//  QRCodeReader
//
//  Created by Han_Luo on 14/07/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class NumberEnteringViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func cancelButton(sender: AnyObject) {
        numberTextField.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneButton.enabled = (newText.length > 0)
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "enterNumber" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! JobDetailsTableViewController
            controller.outputDigit = numberTextField.text
        }
    }

    

   
}

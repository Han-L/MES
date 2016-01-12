//
//  JobDetailsTableViewController.swift
//  QRCodeReader
//
//  Created by Han_Luo on 14/07/2015.
//  Copyright (c) 2015 Han_Luo. All rightsvarserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class PersonalInformationTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var accessRightLabel: UILabel!
    
    var alamofireManager: Alamofire.Manager?
    var hud = MBProgressHUD()
    
    var idNumber: String?
    var visitorModeOn: Bool?
    var information = [String]()
    
    @IBAction func login() {
//        staff.name = nameLabel.text
//        staff.idNumber = idNumberLabel.text
//        staff.accessRight = accessRightLabel.text
        staff = Staff(name: nameLabel.text, idNumber: idNumberLabel.text, accessRight: accessRightLabel.text)
        performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func logout() {
        resetStaff()
        resetCard()
        if visitorModeOn! {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            let myStoryBoard = self.storyboard
            let mainVC = myStoryBoard!.instantiateViewControllerWithIdentifier("main")
            mainVC.modalTransitionStyle = .CrossDissolve
            presentViewController(mainVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        if visitorModeOn! {
            setVisitorModeOn()
            self.navigationItem.rightBarButtonItem?.enabled = true
        } else {
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "请稍候…"
            
            network()
        }
    }
    
    private func setVisitorModeOn() {
        nameLabel.text = "访客"
        idNumberLabel.text = "访客"
        accessRightLabel.text = "以访客登录功能将有所限制"

    }
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/selectPersonInfo?Pnum=\(idNumber!)").responseData { response in
            print(response.result)
            
            if response.data != nil {
                self.parseXML(response.data!)
                
                print("This is all the information:\(self.information)")
                
                if !self.information.isEmpty {
                    self.hud.hide(true)
                    self.configureLabelText()
                } else {
                    self.hud.hide(true)
                    let alert = UIAlertController(title: "提示", message: "此账号不存在或网络连接出错", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "确认", style: .Default, handler: {(action) -> Void in
                        let myStoryBoard = self.storyboard
                        let mainVC = myStoryBoard!.instantiateViewControllerWithIdentifier("main")
                        mainVC.modalTransitionStyle = .CrossDissolve
                        self.presentViewController(mainVC, animated: true, completion: nil)})
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
        
        
    }

    private func parseXML(data: NSData) {
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(string)
        let parser = NSXMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    private func configureLabelText() {
        idNumberLabel.text = information[0]
        nameLabel.text = information[1]
        accessRightLabel.text = information[3]
        self.navigationItem.rightBarButtonItem?.enabled = true
    }

}


extension PersonalInformationTableViewController: NSXMLParserDelegate {
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if string.hasPrefix("\n") {
            return
        }
        information = information + [string]
        print("This is string: \(string)")
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseErrorOccurred: \(parseError)")
    }
}

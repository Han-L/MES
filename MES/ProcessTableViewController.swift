//
//  ProcessTableViewController.swift
//  MES
//
//  Created by Han_Luo on 13/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ProcessTableViewController: UITableViewController {
    
    var alamofireManager: Alamofire.Manager?
    
    var information = [String]()
    
    var hud = MBProgressHUD()
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/selectAWCatalog_1").responseData { response in
            print(response)
            print(response.result)
            print(response.data)
            
            if response.data != nil {
                self.parseXML(response.data!)
                
                print("This is all the information:\(self.information)")
                
                if self.information.isEmpty {
                    self.hud.hide(true)
                    let alert = UIAlertController(title: "提示", message: "网络连接出错", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "确认", style: .Default, handler: { action in
                    self.navigationController?.popViewControllerAnimated(true)})
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            self.hud.hide(true)
            self.tableView.reloadData()
        }
    }
    
    private func parseXML(data: NSData) {
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(string)
        let parser = NSXMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "请稍候…"

        tableView.tableFooterView = UIView()
        network()
        
    }
  
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        if let accessNumber = NSNumberFormatter().numberFromString(staff.accessRight!)?.intValue {
//            if accessNumber <= 3 {
//                return 2
//            } else {
//                return 1
//            }
//        }
        
        if card.cardType != nil {
            return 2
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return information.count
        } else {
            return 2
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("process", forIndexPath: indexPath)
        
        switch indexPath.section {
            
        case 0:
            cell.textLabel!.text = information[indexPath.row]
            cell.textLabel!.textColor = UIColor.darkTextColor()
            cell.textLabel!.textAlignment = .Natural
            cell.accessoryType = .DisclosureIndicator
        case 1:
            let titleArray = ["质量控制点-总结", "记录详情查看"]
            cell.textLabel!.text = titleArray[indexPath.row]
            cell.textLabel!.textColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1)
            cell.textLabel!.textAlignment = .Center
            cell.accessoryType = .None
            
        default: break
        }
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        process = indexPath.row
        let sender = tableView.cellForRowAtIndexPath(indexPath)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            performSegueWithIdentifier("process", sender: sender)
        } else if indexPath.row == 0 {
            performSegueWithIdentifier("qualityControl", sender: sender)
        } else if indexPath.row == 1 {
            performSegueWithIdentifier("recordReview", sender: sender)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? DetailedProcessTableViewController {
            let cell = sender as! UITableViewCell
            controller.title = cell.textLabel!.text
            let indexPath = tableView.indexPathForCell(cell)!
            controller.boardProcess = processes[indexPath.row]
        }
    }
    
    var isCombining = true
    var temporaryString = ""
}


extension ProcessTableViewController: NSXMLParserDelegate {
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "string" {
            isCombining = true
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "string" {
            isCombining = false
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let newString = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if isCombining {
            temporaryString += newString
        } else {
            information += [temporaryString]
            temporaryString = ""
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseErrorOccurred: \(parseError)")
    }
}


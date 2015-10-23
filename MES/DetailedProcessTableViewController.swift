//
//  DetailedProcessTableViewController.swift
//  MES
//
//  Created by Han_Luo on 14/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class DetailedProcessTableViewController: UITableViewController {

    var alamofireManager: Alamofire.Manager?
    var hud = MBProgressHUD()
    
    var information = [String]()
    
    var boardProcess: String?
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/\(boardProcess!)").responseData { response in
            print(response.result)
            
            if response.data != nil {
                self.parseXML(response.data!)
                
                print("This is all the information:\(self.information)")
                
                if self.information.isEmpty {
                    self.hud.hide(true)
                    let alert = UIAlertController(title: "提示", message: "网络连接出错", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "确认", style: .Default, handler: {action in
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("process", forIndexPath: indexPath)
        
        cell.textLabel!.text = information[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? FinalViewController {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            controller.finalProcess = operationCodes[process!][indexPath.row]
        }
    }
    
    var isCombining = true
    var temporaryString = ""
}


extension DetailedProcessTableViewController: NSXMLParserDelegate {
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

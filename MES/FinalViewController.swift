//
//  FinalViewController.swift
//  MES
//
//  Created by Han_Luo on 14/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class FinalViewController: UIViewController {
    
    var alamofireManager: Alamofire.Manager?
    var hud = MBProgressHUD()
    
    var finalProcess: String?

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var QCPButton: UIBarButtonItem!
    
    var information = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QCPButton.enabled = false
        if let accessNumber = NSNumberFormatter().numberFromString(staff.accessRight!)?.intValue {
            if accessNumber <= 3 {
                QCPButton.enabled = true
            }
        }
        
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "请稍候…"

        network()
        
    }
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/selectAWSingleInfo?AW_Step_Num=\(finalProcess!)").responseData { response in
            print(response.result)
            
            if response.data != nil {
                self.parseXML(response.data!)
                
                print("This is all the information:\(self.information)")
                
                if self.information.isEmpty {
                    self.hud.hide(true)
                    let alert = UIAlertController(title: "提示", message: "网络连接出错", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "确认", style: .Default, handler: {action in self.navigationController?.popViewControllerAnimated(true)})
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
            }
            self.hud.hide(true)
            self.textView.text = self.information[0]
        }
    }

    
    private func parseXML(data: NSData) {
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(string)
        let parser = NSXMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? QualityControlPointViewController {
            controller.finalProcess = self.finalProcess
        }
    }
}


extension FinalViewController: NSXMLParserDelegate {
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if !string.hasPrefix("\n") {
            information += [string]
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseErrorOccurred: \(parseError)")
    }
}


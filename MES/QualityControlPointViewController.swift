//
//  QualityControlPointViewController.swift
//  MES
//
//  Created by Han_Luo on 15/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class QualityControlPointViewController: UIViewController{
    
    var alamofireManager: Alamofire.Manager?
    var hud = MBProgressHUD()
    
    var finalProcess: String?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBAction func ok() {
        stateLabel.text = "记录结果：OK"
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    @IBAction func ng() {
        stateLabel.text = "记录结果：NG"
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    @IBAction func save(sender: AnyObject) {
        
    }
    
    
    var information = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.enabled = false
        textView.editable = false
        
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "请稍候…"
        
        network()
        
    }
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/selectAWQualityPointInfo?AW_Step_Num=\(finalProcess!)").responseData { response in
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
    
    
}


extension QualityControlPointViewController: NSXMLParserDelegate {
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if !string.hasPrefix("\n") {
            information += [string]
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseErrorOccurred: \(parseError)")
    }
}


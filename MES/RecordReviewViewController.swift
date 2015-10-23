//
//  RecordReviewViewController.swift
//  MES
//
//  Created by Han_Luo on 22/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit
import Alamofire

class RecordReviewViewController: UIViewController {

    var alamofireManager: Alamofire.Manager?
    
    var information = [String]()
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/selectRecordInfoByCard?Card_Type=\(card.cardType!)&Card_Serial=\(card.cardSerial!)&Man_Name=\(card.manName!)&Production_Batch=\(card.productionBatch!)").responseData { response in
            print(response.result)
            
            if response.data != nil {
                self.parseXML(response.data!)
                
                print("This is all the information:\(self.information)")
                
                if self.information.isEmpty {
                    let alert = UIAlertController(title: "提示", message: "网络连接出错", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "确认", style: .Default, handler: nil)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network()
    }
    
    
    
    var isCombining = true
    var temporaryString = ""

}


extension RecordReviewViewController: NSXMLParserDelegate {
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




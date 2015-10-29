//
//  RecordReviewViewController.swift
//  MES
//
//  Created by Han_Luo on 22/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class RecordReviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var alamofireManager: Alamofire.Manager?
    var hud = MBProgressHUD()
    
    var information = [String]()
    
    private func network() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 3
        
        alamofireManager = Alamofire.Manager(configuration: configuration)
        
        alamofireManager!.request(.GET, "http://172.16.101.116:3333/Service1.asmx/selectRecordInfoByCard", parameters: ["Card_Type": "\(card.cardType!)", "Card_Serial": "\(card.cardSerial!)", "Man_Name": "\(card.manName!)", "Production_Batch": "\(card.productionBatch!)"]).responseData { response in
            print(response.result)
            
            if response.data != nil {
                self.parseXML(response.data!)
                
                print("This is all the information:\(self.information)")
                
                if self.information.isEmpty {
                    self.hud.hide(true)
                    let alert = UIAlertController(title: "提示", message: "网络连接出错", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "确认", style: .Default, handler: nil)
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
        
        let cellNib = UINib(nibName: "RecordReviewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "RecordReviewCell")
        
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "请稍候…"
        
        tableView.tableFooterView = UIView()
        network()
    }

}

extension RecordReviewViewController: UITableViewDelegate {
    
}

extension RecordReviewViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count / 5 + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordReviewCell", forIndexPath: indexPath) as! RecordReviewCell
        if indexPath.row == 0 {
            cell.nameLabel.text = "姓名"
            cell.numberLabel.text = "工号"
            cell.operationLabel.text = "工序"
            cell.resultLabel.text = "结果"
            cell.dateLabel.text = "日期"
            //cell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        } else {
            cell.nameLabel.text = information[(indexPath.row - 1) * 5 + 1]
            cell.numberLabel.text = information[(indexPath.row - 1) * 5]
            cell.operationLabel.text = information[(indexPath.row - 1) * 5 + 2]
            cell.resultLabel.text = information[(indexPath.row - 1) * 5 + 3]
            cell.dateLabel.text = information[(indexPath.row - 1) * 5 + 4]
        }
        return cell
    }
    
}





extension RecordReviewViewController: NSXMLParserDelegate {
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let newString = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if newString != "" {
            information += [newString]
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseErrorOccurred: \(parseError)")
    }
}




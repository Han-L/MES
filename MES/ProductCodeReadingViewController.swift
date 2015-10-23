//
//  ProductCodeReadingViewController.swift
//  MES
//
//  Created by Han_Luo on 13/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit

class ProductCodeReadingViewController: QRCodeReadingViewController {
    
    override func showResults(decodedNumber: String) {
        let alertPrompt = UIAlertController(title: "扫入", message: "你即将扫入 \(decodedNumber)", preferredStyle: .ActionSheet)
        
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            self.barCodeDetected = false
            self.configureCardInformation(decodedNumber)
            
            let myStoryBoard = self.storyboard
            let vc = myStoryBoard!.instantiateViewControllerWithIdentifier("process")
            self.navigationController?.pushViewController(vc, animated: true)
            
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            self.barCodeDetected = false
        })
        
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        
        presentViewController(alertPrompt, animated: true, completion: nil)
    }
    
    var digitsArray = [String]()
    
    func configureCardInformation(theString: String) {
        digitsArray = theString.componentsSeparatedByString(",")
        print(digitsArray)
        card.cardType = digitsArray[0]
        card.cardSerial = digitsArray[1]
        card.manName = digitsArray[2]
        card.productionBatch = digitsArray[3]
    }

}

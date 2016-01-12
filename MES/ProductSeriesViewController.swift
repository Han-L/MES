//
//  ProductSeriesCollectionViewController.swift
//  MES
//
//  Created by Han_Luo on 08/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "productSeries"
private let sectionInsects = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
private let product = [["name": productSeries[0], "image": "\(productSeries[0]).png"],
    ["name": productSeries[1], "image": "\(productSeries[1]).png"],
    ["name": productSeries[2], "image": "\(productSeries[2]).png"],
    ["name": productSeries[3], "image": "\(productSeries[3]).png"]]



class ProductSeriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBAction func goBack() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tvc = segue.destinationViewController as? BoardTypeTableViewController {
            tvc.title = (sender!.contentView.viewWithTag(1001) as! UILabel).text! + "卡件类型"
        }
        
//        if segue.identifier == "logoutPage" {
//            if let tvc = segue.destinationViewController as? LogoutTableViewController {
//                if let ppc = tvc.popoverPresentationController {
//                    ppc.permittedArrowDirections = UIPopoverArrowDirection.Up
//                    ppc.delegate = self
//                }
//            }
//        }
    }
    
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.None
//    }


    // MARK: UICollectionViewDataSource

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        (cell.contentView.viewWithTag(1001) as! UILabel).text = product[indexPath.item]["name"]
        (cell.contentView.viewWithTag(1000) as! UIImageView).image = UIImage(named: product[indexPath.item]["image"]!)
    
        return cell
    }

}


extension ProductSeriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 30
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsects
    }
}

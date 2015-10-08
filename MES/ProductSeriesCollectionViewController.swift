//
//  ProductSeriesCollectionViewController.swift
//  MES
//
//  Created by Han_Luo on 08/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "productSeries"
private let sectionInsects = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
private let product = [["name": "SUPERMAX 800", "image": "SUPERMAX 800.png"],
    ["name": "SUPERMAX 2000", "image": "SUPERMAX 2000.png"],
    ["name": "NuPAC", "image": "NuPAC.png"],
    ["name": "压力变送器", "image": "压力变送器.png"],
]

class ProductSeriesCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return product.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        (cell.contentView.viewWithTag(1001) as! UILabel).text = product[indexPath.item]["name"]
        (cell.contentView.viewWithTag(1000) as! UIImageView).image = UIImage(named: product[indexPath.item]["image"]!)
    
        return cell
    }
    
    
    

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}


extension ProductSeriesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 30
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsects
    }
}

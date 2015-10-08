//
//  PhotoImage.swift
//  ArcaneDiary
//
//  Created by Han_Luo on 15/09/2015.
//  Copyright (c) 2015 Han_Luo. All rights reserved.
//

import UIKit

class PhotoImage: UIImageView {

    override func awakeFromNib() {
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 3
    }
}
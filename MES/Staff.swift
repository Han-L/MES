//
//  Staff.swift
//  MES
//
//  Created by Han_Luo on 13/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import Foundation

var staff = Staff()

class Staff {
    var name: String?
    var idNumber: String?
    var accessRight: String?
    
    init(name: String?, idNumber: String?, accessRight: String?) {
        self.name = name
        self.idNumber = idNumber
        self.accessRight = accessRight
    }
    
    init() {}
}

func resetStaff() {
    staff = Staff()
}
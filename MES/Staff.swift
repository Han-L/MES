//
//  Staff.swift
//  MES
//
//  Created by Han_Luo on 13/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import Foundation

var staff = Staff()

struct Staff {
    var name: String?
    var idNumber: String?
    var accessRight: String?
}

func resetStaff() {
    staff.name = nil
    staff.idNumber = nil
    staff.accessRight = nil
}
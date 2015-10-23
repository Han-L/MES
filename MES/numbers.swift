//
//  productSeries.swift
//  MES
//
//  Created by Han_Luo on 14/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import Foundation

let boardType = ["AW610310-V1.0-载卡", "AW610320-V1.0-逻辑子卡", "AW610330-V1.0-模拟量输出子卡", "AW610340-V1.0-开关量/脉冲输入子卡", "AW610350-V1.0-温度输入子卡", "AW610360-V1.0-RS422-485子卡", "AW610370-V1.0-模拟量输出子卡", "AW610380-V1.0-固态继电器子卡", "AW610120-V1.0-后传输模块"]

let productSeries = ["SUPERMAX 800", "SUPERMAX 2000", "NUPAC", "压力变送器"]

var process: Int?

let processes = ["selectAW_A", "selectAW_A_PL", "selectAW_B", "selectAW_B_PL", "selectAW_FB", "selectAW_GNCS"]

let processNums = ["5000", "6000", "7000", "8000", "9000", "4000"]

let operationCodes = [["5001", "5002", "5003", "5004", "5005"], ["6001", "6002", "6003", "6004", "6005"], ["7001", "7002", "7003", "7004"], ["8001", "8002", "8003", "8004"], ["9001", "9002"], ["4001"]]

struct boardTypeNum {
    static let 载卡 = 610310
    static let 逻辑子卡 = 610320
    static let 模拟量输出子卡 = 610330
    static let 开关量脉冲输入子卡 = 610340
    static let 温度输入子卡 = 610350
    static let RS422485子卡 = 610360
    static let 模拟量输出子卡2 = 610370
    static let 固态继电器子卡 = 610380
    static let 后传输模块 = 610120
}

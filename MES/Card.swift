//
//  Card.swift
//  MES
//
//  Created by Han_Luo on 22/10/2015.
//  Copyright © 2015 Han_Luo. All rights reserved.
//

import Foundation

var card = Card()

struct Card {
    var cardType: String?
    var cardSerial: String?
    var manName: String?
    var productionBatch: String?
}

func resetCard() {
    card.cardType = nil
    card.cardSerial = nil
    card.manName = nil
    card.productionBatch = nil
}
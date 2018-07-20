//
//  Order.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-19.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class Order {
    
    var id: Int
    //var items: [Item]
    var totalPrice: Double
    var yearCreated: Int
    var province: String
    
    init(inpId: Int, inpTotalPrice: Double, inpYearCreated: Int, inpProvince: String) {
        
        id = inpId
        totalPrice = inpTotalPrice
        yearCreated = inpYearCreated
        province = inpProvince
        
    }
    

}

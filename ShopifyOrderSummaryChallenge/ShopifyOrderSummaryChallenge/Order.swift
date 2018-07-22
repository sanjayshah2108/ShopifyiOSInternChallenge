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
    var customerName: String
    var totalPrice: Double
    var yearCreated: Int
    var province: String
    
    init(inpId: Int, inpCustomerName: String, inpTotalPrice: Double, inpYearCreated: Int, inpProvince: String) {
        
        id = inpId
        customerName = inpCustomerName
        totalPrice = inpTotalPrice
        yearCreated = inpYearCreated
        province = inpProvince
        
    }
    

}

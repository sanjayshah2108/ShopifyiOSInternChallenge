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
    var name: String
    var numberOfItems: Int
    var customerName: String
    var totalPrice: Double
    var yearCreated: Int
    var province: String
    
    
    init(inpId: Int, inpName: String, inpCustomerName: String, inpTotalPrice: Double, inpYearCreated: Int, inpProvince: String, inpNumberOfItems: Int) {
        
        id = inpId
        name = inpName
        customerName = inpCustomerName
        totalPrice = inpTotalPrice
        yearCreated = inpYearCreated
        province = inpProvince
        numberOfItems = inpNumberOfItems
        
    }
    

}

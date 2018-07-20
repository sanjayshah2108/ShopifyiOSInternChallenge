//
//  Data.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-19.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class Data: NSObject {
    
    static let shared = Data()
    
    public var orders: [Order]
    public var provinces: [String]
    
    public override init() {
        orders = []
        provinces = []
    }
    
    public func getNumberOfOrdersForThisProvince(section: Int) -> Int {
        
        var numberOfOrdersForThisProvince = 0
        
        for order in Data.shared.orders {
            
            if (order.province == Data.shared.provinces[section]){
                numberOfOrdersForThisProvince += 1
            }
            
        }
        
        return numberOfOrdersForThisProvince
    }
    

}

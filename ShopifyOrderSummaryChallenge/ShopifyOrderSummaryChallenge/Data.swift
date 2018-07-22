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
    
    public func getNumberOfOrdersForThisProvince(province: String) -> Int {
        
        var numberOfOrdersForThisProvince = 0
        
        for order in Data.shared.orders {
            
            if (order.province == province){
                numberOfOrdersForThisProvince += 1
            }
            
        }
        
        return numberOfOrdersForThisProvince
    }
    
    public func getProvincesFromOrders(){
        
        for order in orders {
            
            if !(provinces.contains(order.province)){
                provinces.append(order.province)
            }
            
        }
        
        sortProvincesAlphabetically()
    }
    
    private func sortProvincesAlphabetically(){
        
        Data.shared.provinces.sort(by: { (value1: String, value2: String) -> Bool in
            return value1 < value2 })
        
    }
    
    public func getNumberOfOrdersForThisYear(year: Int) -> Int {
        
        var numberOfOrdersCreatedInThisYear = 0
        
        for order in Data.shared.orders {
            
            if order.yearCreated == year{
                numberOfOrdersCreatedInThisYear += 1
                
            }
        }
        
        return numberOfOrdersCreatedInThisYear
        
    }
    
    public func getOrdersForThisYear(year: Int) -> [Order] {
        
        var ordersForThisYear: [Order] = []
        
        for order in Data.shared.orders {
            
            if order.yearCreated == year{
                ordersForThisYear.append(order)
                
            }
        }
        
        return ordersForThisYear
        
    }
    

}

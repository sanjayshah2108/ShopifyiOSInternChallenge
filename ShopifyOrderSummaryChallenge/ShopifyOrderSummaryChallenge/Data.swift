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
    
    public override init() {
        orders = []
    }
    

}

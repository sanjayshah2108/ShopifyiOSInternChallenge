//
//  ProvinceViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-18.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class ProvinceViewController: UIViewController {
    
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempArr = []
        ReadAPI.fetchData(completion:{ readOrders in
        
            self.orders = readOrders
            
        
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


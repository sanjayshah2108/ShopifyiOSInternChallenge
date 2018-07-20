//
//  ViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-18.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tempArr: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempArr = []
        ReadAPI.fetchData(completion:{ orders in
        
            self.tempArr = orders
            
        
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


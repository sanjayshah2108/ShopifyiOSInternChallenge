//
//  YearDetailedSummaryViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-20.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class YearDetailedSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var detailedTableView: UITableView!
    
    var ordersForThisYear: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedTableView.delegate = self
        detailedTableView.dataSource = self
        detailedTableView.register(UINib(nibName: "OrderDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "orderDetailsTableViewCell")
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let ordersForThisYear = ordersForThisYear {
            
            //set max to 10
            if(ordersForThisYear.count > 10){
                return 10
            }
            else {
                return  ordersForThisYear.count
            }
        }
        
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsTableViewCell") as! OrderDetailsTableViewCell
        
        //forve unwrapping here because cellForRowAtIndexPath only runs if numberOfRowsInSection returns > 0 which is only possible if ordersIn2017 is not nil
        
        let order = ordersForThisYear![indexPath.row]
        
        cell.orderIdLabel.text = "ID: \(order.id)"
        cell.orderNameLabel.text = order.name
        cell.orderTotalPriceLabel.text = "$\(order.totalPrice)"
        cell.orderCustomerNameLabel.text = order.customerName
        
        if(order.numberOfItems > 1){
            cell.orderNumberOfItemsLabel.text = "\(order.numberOfItems) items"
        }
        else {
            cell.orderNumberOfItemsLabel.text = "\(order.numberOfItems) item"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "2017"
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

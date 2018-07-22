//
//  YearSummaryViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-20.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class YearSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ordersIn2017: [Order]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let ordersIn2017 = ordersIn2017 {
            return  ordersIn2017.count
        }
        
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "numberOfOrdersByYearCell") as! OrderDetailsTableViewCell
        
        //forve unwrapping here because cellForRowAtIndexPath only runs if numberOfRowsInSection returns > 0 which is only possible if ordersIn2017 is not nil
        
        let order = ordersIn2017![indexPath.row]
        
        cell.orderIdLabel.text = "\(order.id)"
        cell.orderTotalPriceLabel.text = "$\(order.totalPrice)"
        cell.orderCustomerEmailLabel.text = "email"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

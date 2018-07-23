//
//  ProvinceDetailedSummaryViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-19.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class ProvinceDetailedSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentProvince: String!
    var ordersForCurrentProvince: [Order]?
    
    @IBOutlet weak var detailedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedTableView.delegate = self
        detailedTableView.dataSource = self
        
        if (currentProvince != "All"){
            ordersForCurrentProvince = Data.shared.getOrdersForThisProvince(province: currentProvince)
        }
        else {
            
            ordersForCurrentProvince = Data.shared.orders
            
        }

        detailedTableView.register(UINib(nibName: "OrderDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "orderDetailsTableViewCell")
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if(currentProvince != "All"){
            return 1
        }
        else {
            return Data.shared.provinces.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        if(currentProvince != "All"){
            return currentProvince
        }
        else {
            return Data.shared.provinces[section]
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowsCount: Int
        
        if (currentProvince != "All"){
        
            rowsCount =  Data.shared.getNumberOfOrdersForThisProvince(province: currentProvince)
        }
        else {
            rowsCount = Data.shared.getNumberOfOrdersForThisProvince(province: Data.shared.provinces[section])
        }
        
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: OrderDetailsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "orderDetailsTableViewCell") as? OrderDetailsTableViewCell
        
        var order: Order
        
        guard let ordersForCurrentProvince = ordersForCurrentProvince else {
            return cell
        }
      
        order = ordersForCurrentProvince[indexPath.row]
        
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

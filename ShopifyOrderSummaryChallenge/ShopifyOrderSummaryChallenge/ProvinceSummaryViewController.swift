//
//  ProvinceSummaryViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-18.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class ProvinceSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var summaryTableView: UITableView!
    
    var orders: [Order]?
    var provinces: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryTableView.delegate = self
        summaryTableView.dataSource = self
        //tempArr = []
        ReadAPI.fetchData(completion:{ readOrders in
        
            Data.shared.orders = readOrders
            
            self.getProvincesFromOrders()
            
            DispatchQueue.main.async {
                self.summaryTableView.reloadData()
            }
            
            
        
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProvincesFromOrders(){
        
        //provinces = []
        
        for order in Data.shared.orders {
            
            if !(provinces.contains(order.province)){
                provinces.append(order.province)
            }
            
        }
        
        sortProvincesAlphabetically()
     
        
    }
    
    func sortProvincesAlphabetically(){
        
        //can prob move this up into parent func
        provinces.sort(by: { (value1: String, value2: String) -> Bool in
            return value1 < value2 })
        
    }
    
    @IBAction func viewAllProvinces(_ sender: UIButton) {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return provinces.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return provinces[section]

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "numberOfOrdersByProvinceCell") as! UITableViewCell

        let numberOfOrdersForThisProvince = getNumberOfOrdersForThisProvince(section: indexPath.section)

        let provinceName = provinces[indexPath.section]

        cell.textLabel?.text = "\(numberOfOrdersForThisProvince) number of orders from \(provinceName)"

        return cell
    }
    
    
    
    func getNumberOfOrdersForThisProvince(section: Int) -> Int {
        
        var numberOfOrdersForThisProvince = 0
        
        for order in Data.shared.orders {
            
            if (order.province == provinces[section]){
                numberOfOrdersForThisProvince += 1
            }
            
        }
        
        return numberOfOrdersForThisProvince
    }
    
    
}


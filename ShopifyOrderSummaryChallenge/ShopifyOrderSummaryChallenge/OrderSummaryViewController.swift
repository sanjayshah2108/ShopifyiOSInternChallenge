//
//  OrderSummaryViewController
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-18.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ordersByYearHeading: UIView!
    
    @IBOutlet weak var ordersByProvinceHeading: UIView!
    
    
    @IBOutlet weak var ordersIn2017Label: UILabel!
    
    @IBOutlet weak var summaryTableView: UITableView!
    
    
    var orders: [Order]?
    var selectedProvince: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryTableView.delegate = self
        summaryTableView.dataSource = self
        //tempArr = []
        ReadAPI.fetchData(completion:{ readOrders in
        
            Data.shared.orders = readOrders
            
            self.getProvincesFromOrders()
            let ordersIn2017 = self.getOrdersCreatedIn2017()
            
            DispatchQueue.main.async {
                self.summaryTableView.reloadData()
                self.ordersIn2017Label.text = "There were \(ordersIn2017) created in 2017"
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
            
            if !(Data.shared.provinces.contains(order.province)){
                Data.shared.provinces.append(order.province)
            }
            
        }
        
        sortProvincesAlphabetically()
     
        
    }
    
    func sortProvincesAlphabetically(){
        
        //can prob move this up into parent func
        Data.shared.provinces.sort(by: { (value1: String, value2: String) -> Bool in
            return value1 < value2 })
        
    }
    
    @IBAction func viewAllProvinces(_ sender: UIButton) {
        
        selectedProvince = "All"
        performSegue(withIdentifier: "showProvinceDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showProvinceDetails") {
            
            //segue.destination
            let destination = segue.destination as! ProvinceDetailedSummaryViewController
            
            destination.currentProvince = selectedProvince
            
            
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.shared.provinces.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return provinces[section]
//
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "numberOfOrdersByProvinceCell")

        let numberOfOrdersForThisProvince = Data.shared.getNumberOfOrdersForThisProvince(province: Data.shared.provinces[indexPath.section])

        let provinceName = Data.shared.provinces[indexPath.section]

        cell.textLabel?.text = "\(numberOfOrdersForThisProvince) number of orders from \(provinceName)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        selectedProvince = Data.shared.provinces[indexPath.section]
        
        performSegue(withIdentifier: "showProvinceDetails", sender: self)
        
        
    }
    
    func getOrdersCreatedIn2017() -> [Order]{
        
        var ordersIn2017: [Order] = []
        
        for order in Data.shared.orders {
            
            if order.yearCreated == 2017{
                ordersIn2017.append(order)
                
            }
        }
        
        return ordersIn2017
    }
    
//    func getNumberOfOrdersForThisProvince(section: Int) -> Int {
//
//        var numberOfOrdersForThisProvince = 0
//
//        for order in Data.shared.orders {
//
//            if (order.province == Data.shared.provinces[section]){
//                numberOfOrdersForThisProvince += 1
//            }
//
//        }
//
//        return numberOfOrdersForThisProvince
//    }
    
    
}


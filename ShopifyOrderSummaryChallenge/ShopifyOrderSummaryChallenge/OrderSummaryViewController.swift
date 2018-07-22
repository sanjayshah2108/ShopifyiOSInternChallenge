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
        
        ReadAPI.fetchData(completion:{ readOrders in
        
            Data.shared.orders = readOrders
            
            Data.shared.getProvincesFromOrders()
            
            let numberOfOrdersIn2017 = Data.shared.getNumberOfOrdersForThisYear(year: 2017)
            
            DispatchQueue.main.async {
                
                self.summaryTableView.reloadData()
                self.ordersIn2017Label.text = "\(numberOfOrdersIn2017) orders created in 2017"
            }
        })
        
        addTapGestureRecognizersToHeadings()
    
    }
    
    func addTapGestureRecognizersToHeadings(){
        
        let yearHeadingTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToYearDetailsViewController))
        
        ordersByYearHeading.addGestureRecognizer(yearHeadingTapGesture)
        
        let provinceHeadingTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToProvinceDetailsViewController))
        
        ordersByProvinceHeading.addGestureRecognizer(provinceHeadingTapGesture)
        
    }
    
    
    @objc func goToYearDetailsViewController(sender: UITapGestureRecognizer){
        
        performSegue(withIdentifier: "showYearDetails", sender: self)
        
        
    }
    
    @objc func goToProvinceDetailsViewController(sender: UITapGestureRecognizer){
        
        selectedProvince = "All"
        performSegue(withIdentifier: "showProvinceDetails", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showProvinceDetails") {
            
            //segue.destination
            let destination = segue.destination as! ProvinceDetailedSummaryViewController
            
            destination.currentProvince = selectedProvince
        }
        
        else if (segue.identifier == "showYearDetails") {
            
            //segue.destination
            let destination = segue.destination as! YearDetailedSummaryViewController
            
            destination.ordersForThisYear =  Data.shared.getOrdersForThisYear(year: 2017)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.shared.provinces.count
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "numberOfOrdersByProvinceCell")

        let numberOfOrdersForThisProvince = Data.shared.getNumberOfOrdersForThisProvince(province: Data.shared.provinces[indexPath.section])

        let provinceName = Data.shared.provinces[indexPath.section]

        cell.textLabel?.text = "\(numberOfOrdersForThisProvince) orders from \(provinceName)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        selectedProvince = Data.shared.provinces[indexPath.section]
        
        performSegue(withIdentifier: "showProvinceDetails", sender: self)
        
        
    }

}


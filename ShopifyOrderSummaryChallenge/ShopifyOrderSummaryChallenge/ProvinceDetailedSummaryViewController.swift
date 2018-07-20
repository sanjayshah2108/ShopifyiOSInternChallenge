//
//  ProvinceDetailedSummaryViewController.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-19.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class ProvinceDetailedSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.shared.provinces.count
    }
    
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
            return Data.shared.provinces[section]
    
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.getNumberOfOrdersForThisProvince(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderInProvinceCell") as! UITableViewCell
        
        
        cell.textLabel?.text = "\(Data.shared.orders[indexPath.row].id)"
        
        return cell
    }
    
    @IBOutlet weak var detailedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailedTableView.delegate = self
        detailedTableView.dataSource = self
        // Do any additional setup after loading the view.
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

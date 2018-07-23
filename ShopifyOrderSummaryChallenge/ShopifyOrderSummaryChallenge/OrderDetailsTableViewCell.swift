//
//  OrderDetailsTableViewCell.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-21.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var orderNameLabel: UILabel!
    
    @IBOutlet weak var orderCustomerNameLabel: UILabel!
    
    @IBOutlet weak var orderTotalPriceLabel: UILabel!
    
    @IBOutlet weak var orderNumberOfItemsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

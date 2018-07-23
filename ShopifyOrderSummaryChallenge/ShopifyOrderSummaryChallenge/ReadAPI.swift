//
//  ReadAPI.swift
//  ShopifyOrderSummaryChallenge
//
//  Created by Sanjay Shah on 2018-07-19.
//  Copyright © 2018 Sanjay Shah. All rights reserved.
//

import UIKit

class ReadAPI  {
    
    class func fetchData(completion: @escaping ([Order])->()){
        
        var ordersArray: [Order] = []
        
        let url = URL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
        let session = URLSession.shared
        
        if let usableUrl = url {
            
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                //if data exists
                if let data = data {
                    
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data, options: [])
                        
                        //access json as a dict
                        if let object = json as? [String: Any],
                            
                            //access orders as an array of dicts
                            let orders = object["orders"] as? [[String: Any]]  {
                            
                            var countIndex = 0;
                            
                            for order in orders {
                                
                                countIndex += 1
                                
                                var orderId: Int = 0
                                var orderName: String = "Unknown"
                                var orderTotalPriceAsDouble: Double = 0.0
                                var orderYearCreated: Int = 0
                                var orderProvince: String = "Unknown"
                                var orderCustomerName: String = "Unknown"
                                var orderNumberOfItems: Int = 0
                                
                                //orderId
                                if let readOrderId = order["id"] as? Int {
                                    orderId = readOrderId
                                }
                                
                                //orderName
                                if let readOrderName = order["name"] as? String {
                                    orderName = readOrderName
                                }
    
                                //totalPrice
                                if let readOrderTotalPriceAsString = order["total_price"] as? String,
                                    let readOrderTotalPriceAsDouble = Double(readOrderTotalPriceAsString) {
                                    
                                    orderTotalPriceAsDouble = readOrderTotalPriceAsDouble
                                }
               
                                //yearCreated
                                if let readOrderCreatedAt = order["created_at"] as? String {
                                   orderYearCreated = convertDateToYear(date: readOrderCreatedAt)
                                }
                                
                                
                                //shipping address
                                if let readShippingAddress = order["shipping_address"] as? [String: Any],
                                    
                                    //province
                                    let readProvince = readShippingAddress["province"] as? String {
                                
                                    orderProvince = readProvince
                                    
                                }
        
                            
                                //customer
                                if let readCustomer = order["customer"] as? [String: Any],
         
                                    //get firstName and lastName of customer
                                    let firstName = readCustomer["first_name"] as? String,
    
                                    let lastName = readCustomer["last_name"] as? String {
                                    
                                    orderCustomerName = firstName + " " + lastName
        
                                }
                                
                                
                                //numberOfItems
                                if let readItems = order["line_items"] as? [[String: Any]] {
                                    
                                    for item in readItems {
                                        
                                        if let quantity = item["quantity"] as? Int {
                                            
                                            orderNumberOfItems += quantity
                                            
                                        }
                                    }
                                }
                                

                                let readOrder = Order(inpId: orderId, inpName: orderName, inpCustomerName: orderCustomerName, inpTotalPrice: Double(orderTotalPriceAsDouble), inpYearCreated: orderYearCreated, inpProvince: orderProvince, inpNumberOfItems: orderNumberOfItems)
                                
                                
                                ordersArray.append(readOrder)
                                
                                //if the countIndex matches the amount of orderDicts in the JSON object, then send the callback
                                if (orders.count == countIndex) {
                                    completion(ordersArray)
                                }
                            }
                        }
                        
                        // json is an array or something else, which we dont expect
                        else {
                            print("JSON is not what we expected it to be")
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    }
    
    
    
    class func convertDateToYear(date: String) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: date) {
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year], from: date)
            
            if let yearAsInt = components.year {
                
                return yearAsInt
            }
            else {
                print("there was an error getting the year from the date")
                return 0
            }
            
        }
        else {
            
            print("there was an error converting the date from a string")
            return 0
            
        }
    }
}

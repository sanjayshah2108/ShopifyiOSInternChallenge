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
                if let data = data {
                    
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data, options: [])
                        if let object = json as? [String: Any] {
                            // json is a dictionary
                            
                            if let orders = object["orders"] as? [[String: Any]] {
                                
                                var countIndex = 0;
                                
                                for order in orders {
                                    
                                    countIndex += 1
                                    
                                    guard let orderId = order["id"] as? Int else {
                                        print("orderId is nil")
                                        continue
                                    }
                                    guard let orderTotalPriceAsString = order["total_price"] as? String else {
                                        print("totalPrice is nil")
                                        continue
                                    }
                                    
                                    guard let orderTotalPriceAsDouble = Double(orderTotalPriceAsString) else {
                                        print("totalPrice is cant be converted to Double")
                                        continue
                                    }
                                    
                                    
                                    
                                    
                                    guard let orderCreatedAt = order["created_at"] as? String else {
                                        print("orderId is nil")
                                        continue
                                    }
                                    
                                    let orderYearCreated = convertDateToYear(date: orderCreatedAt)
                                    
                                    
                                    var orderProvince: String = ""
                                    
                                    
                                    //get shipping address
                                    
                                    if let shippingAddress = order["shipping_address"] as? [String: Any] {
                                        
                                        guard let province = shippingAddress["province"] as? String else {
                                            
                                            print("Error reading province")
                                  
                                            continue
                                            
                                        }
                                        
                                        orderProvince = province
                                        
                                    }
                                    else {
                                        print(order["id"] ?? "xxx")
                                        print("Error reading shipping address")
                                        
                                        //print alert??
                                        orderProvince = "Unknown"
                                        
                                    }
                                    
                                    var customerName: String = ""
                                    
                                    if let customer = order["customer"] as? [String: Any]{
                                        
                                        guard let firstName = customer["first_name"] as? String else {
                                             print("Error reading firstName")
                                            continue
                                            
                                        }
                                        
                                        guard let lastName = customer["last_name"] as? String else {
                                            print("Error reading firstName")
                                            continue
                                            
                                        }
                                
                                        customerName = firstName + " " + lastName
                                        
                                        if(customerName == " "){
                                            customerName = "Unknown"
                                        }
                                        
                                    }
                                    
                                    let readOrder = Order(inpId: orderId, inpCustomerName: customerName, inpTotalPrice: Double(orderTotalPriceAsDouble), inpYearCreated: orderYearCreated, inpProvince: orderProvince)
                                    
                                    
                                    ordersArray.append(readOrder)
                                    
                                    
                                    //                                //MIGHT NOT NEED CUSTOEMR DETAILS
                                    //                                if let customer = order["customer"] as? [String: Any]  {
                                    //
                                    //                                    if let customerId = customer["id"] as? Int {
                                    //                                        if let customerEmail = customer[""] as? String {
                                    //                                            //let customerShippingProvince = customer[""] as? String
                                    //
                                    //
                                    //                                            //Customer
                                    //                                            let newCustomer = Customer(inpId: customerId, inpEmail: customerEmail)
                                    //                                        }
                                    //                                    }
                                    //
                                    //                                }
                                    
                                    
                                    if (orders.count == countIndex) {
                                        
                                        print(ordersArray )
                                        
                                        completion(ordersArray)
                                        
                                        
                                        
                                    }
                                }
                                
                            }
                            
                            
                        } else if let object = json as? [Any] {
                            // json is an array
                            print(object)
                            
                        } else {
                            print("JSON is invalid")
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

//
//  Connection.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 15/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service{
    
    func Registered(url: String, completion: @escaping (_ data: DataResponse<Any>)-> ()){
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                completion(response)
        }
    }
    
    func ulr(name: String, min: String, max: String, wholeshale: Bool, official: Bool, gold: String, start: Int, row: Int)-> String{
        let url = "https://ace.tokopedia.com/search/v2.5/product?q=\(name)&pmin=\(min)&pmax=\(max)&wholesale=\(wholeshale)&official=\(official)&fshop=\(gold)&start=\(start)&rows=\(row)"
        
        return url
    }
}

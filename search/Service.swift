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
import KeychainSwift

class Service{
    
    let key = KeychainSwift()
    
    func Registered(url: String, completion: @escaping (_ data: DataResponse<Any>)-> ()){
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                completion(response)
        }
    }
    
    func url(name: String, min: String, max: String, wholeshale: Bool, official: Bool, gold: String, start: Int, row: Int)-> String{
        let url = "https://ace.tokopedia.com/search/v2.5/product?q=\(name)&pmin=\(min)&pmax=\(max)&wholesale=\(wholeshale)&official=\(official)&fshop=\(gold)&start=\(start)&rows=\(row)"
        
        return url
    }
    
    func setUrl(row: Int)-> String{
        var url = ""
        var keyMax = key.get("max")
        var keyMin = key.get("min")
        var keyWhole = key.getBool("wholeSale")
        var keyOfficial = key.getBool("official")
        var keyGold = key.get("gold")
        
        if keyMax != ""{
            keyMax = key.get("max")
        }else{
            keyMax = "8000000"
        }
        
        if keyMin != ""{
            keyMin = key.get("min")
        }else{
            keyMin = "10000"
        }
        
        if keyOfficial != nil{
            keyOfficial = key.getBool("official")
        }else{
            keyOfficial = true
        }
        
        if keyGold != nil{
            keyGold = key.get("gold")
        }else{
            keyGold = "2"
        }
        
        if keyWhole != nil{
            keyWhole = key.getBool("wholeSale")
        }else{
            keyWhole = true
        }
        
        url = Service().url(name: "Samsung", min: keyMin!, max: keyMax!, wholeshale: keyWhole!, official: keyOfficial!, gold: keyGold!, start: 0, row: row)
        
        return url
    }

}

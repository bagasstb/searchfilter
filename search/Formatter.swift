//
//  Formatter.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 17/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import Foundation

class Formatter{
    
    func separator(value: String?) -> String{
        guard value != nil else { return "0" }
        let doubleValue = Double(value!) ?? 0.0
        print(doubleValue)
        let formatter = NumberFormatter()
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
    }

}

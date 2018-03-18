//
//  Move.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 18/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import Foundation
import UIKit

class Move{
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func toView(identifier: String){
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.window?.rootViewController = homePage
    }

}

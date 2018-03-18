//
//  ShopType.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 16/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import UIKit
import KeychainSwift

class ShopType: UIViewController{

    @IBOutlet weak var goldSwitch: UISwitch!
    @IBOutlet weak var officialSwitch: UISwitch!
    
    var gold = "2"
    var official = true
    let key = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSwitch()
    }
    
    func prepareSwitch(){
        if official == true{
            officialSwitch.setOn(true, animated: true)
        }else{
            officialSwitch.setOn(false, animated: true)
        }
        if gold == "2"{
            goldSwitch.setOn(true, animated: true)
        }else{
            goldSwitch.setOn(false, animated: true)
        }
    }
    
    func setValue(){
        let nav = presentingViewController as! UINavigationController
        let controller = nav.topViewController as! Filter
        
        if official == true{
            controller.officialLabel.isHidden = false
            controller.official = true
        }else if official == false{
            controller.officialLabel.isHidden = true
            controller.official = false
        }
        
        if gold == "2"{
            controller.goldLabel.isHidden = false
            controller.gold = "2"
        }else if gold == "1"{
            controller.goldLabel.isHidden = true
            controller.gold = "1"
        }
    }

    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
   
    @IBAction func goldMerchant(_ sender: UISwitch) {
        if sender.isOn == true{
            gold = "2"
        }else if sender.isOn == false{
            gold = "1"
        }
    }
    
    @IBAction func officialStore(_ sender: UISwitch) {
        if sender.isOn == true{
            official = true
        }else if sender.isOn == false{
            official = false
        }
    }
    
    @IBAction func apply(_ sender: UIButton) {
        setValue()
        key.set(gold, forKey: "gold")
        key.set(official, forKey: "official")
        self.dismiss(animated: true)
    }
}

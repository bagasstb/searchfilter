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

    var gold = ""
    var official = true
    let key = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
   
    @IBAction func goldMerchant(_ sender: UISwitch) {
        if sender.isOn{
            gold = "2"
        }else{
            gold = "1"
        }
    }
    
    func setValue(){
        let nav = presentingViewController as! UINavigationController
        let controller = nav.topViewController as! Filter
        controller.gold = gold
        controller.official = official
    }
    
    @IBAction func officialStore(_ sender: UISwitch) {
        if sender.isOn{
            official = true
        }else{
            official = false
        }
    }
    
    @IBAction func apply(_ sender: UIButton) {
        key.set(gold, forKey: "gold")
        key.set(official, forKey: "official")
        self.dismiss(animated: true)
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

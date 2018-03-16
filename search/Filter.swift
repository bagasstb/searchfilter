//
//  Filter.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 16/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import UIKit
import RangeSeekSlider
import KeychainSwift

class Filter: UIViewController, RangeSeekSliderDelegate {
    
    @IBOutlet weak var seeker: RangeSeekSlider!
    
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var maxValue: UILabel!
    
    var max = ""
    var min = ""
    var gold = ""
    var official = true
    var wholeshale = true
    
    let key = KeychainSwift()
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seeker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === seeker {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            let maxInt = Int(maxValue)
            let minInt = Int(minValue)
            self.max = maxInt.description
            self.min = minInt.description
            let maxFormat = Formatter().separator(value: maxInt.description)
            let minFormat = Formatter().separator(value: minInt.description)
            self.maxValue.text = "Rp \(maxFormat)"
            self.minValue.text = "Rp \(minFormat)"
        }
    }

    @IBAction func wholeSale(_ sender: UISwitch) {
        if sender.isOn{
            wholeshale = true
        }else{
            wholeshale = false
        }
    }
    
    @IBAction func selectType(_ sender: UIButton) {
        performSegue(withIdentifier: "type", sender: UIButton())
    }
    
    @IBAction func filter(_ sender: UIButton) {
        key.set(max, forKey: "max")
        key.set(min, forKey: "min")
        key.set(wholeshale, forKey: "wholeSale")
        toView(identifier: "mainMenu")
    }
    
    func toView(identifier: String){
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.window?.rootViewController = homePage
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

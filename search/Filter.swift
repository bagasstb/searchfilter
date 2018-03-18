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
    
    @IBOutlet weak var wholeSaleSlide: UISwitch!
    @IBOutlet weak var officialLabel: UIView!
    @IBOutlet weak var goldLabel: UIView!
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var maxValue: UILabel!
    
    var max = 8000000
    var min = 10000
    var gold = "2"
    var official = true
    var wholeshale = true
    
    let key = KeychainSwift()
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seeker.delegate = self
        filterSetup()
    }
    
    func filterSetup(){
        
        let keyMax = key.get("max")
        let keyMin = key.get("min")
        let keyWhole = key.getBool("wholeSale")
        let keyOfficial = key.getBool("official")
        let keyGold = key.get("gold")
        if keyMax != ""{
            maxValue.text = "Rp \(Formatter().separator(value: keyMax))"
            let maxFloat = NumberFormatter().number(from: keyMax!)
            seeker.selectedMaxValue = CGFloat(maxFloat!)
            print("maxFlloat: \(CGFloat(maxFloat!))")
            //seeker.maxValue = CGFloat(maxFloat!)
        }else{
            maxValue.text = "Rp 8.000.000"
            seeker.selectedMaxValue = CGFloat(max)
            print("max reset \(CGFloat(max))")
            //seeker.maxValue = CGFloat(max)
        }
        
        if keyMin != ""{
            minValue.text = "Rp \(Formatter().separator(value: keyMin))"
            let minFloat = NumberFormatter().number(from: keyMin!)
            seeker.selectedMinValue = CGFloat(minFloat!)
            print("minFloat: \(CGFloat(minFloat!))")
            //seeker.minValue = CGFloat(minFloat!)
        }else{
            minValue.text = "Rp 10.000"
            seeker.selectedMinValue = CGFloat(min)
            print("min reset\(CGFloat(min))")
            //seeker.minValue = CGFloat(min)
        }
        
        if keyOfficial != nil{
            if keyOfficial == false{
                officialLabel.isHidden = true
                official = false
            }else if keyOfficial == true{
                officialLabel.isHidden = false
                official = true
            }else{
                
            }
        }
        
        if keyGold != nil{
            if keyGold == "1"{
                goldLabel.isHidden = true
                gold = "1"
            }else if keyGold == "2"{
                goldLabel.isHidden = false
                gold = "2"
            }else{
                
            }
        }
        
        if keyWhole != nil{
            wholeSaleSlide.setOn(keyWhole!, animated: true)
        }
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === seeker {
            let maxInt = Int(maxValue)
            let minInt = Int(minValue)
            self.max = maxInt
            self.min = minInt
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
        key.set(max.description, forKey: "max")
        key.set(min.description, forKey: "min")
        key.set(wholeshale, forKey: "wholeSale")
        toView(identifier: "mainMenu")
    }
    
    func toView(identifier: String){
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.window?.rootViewController = homePage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pick: ShopType = segue.destination as? ShopType{
            if official == true{
                pick.official = true
            }else if official == false{
                pick.official = false
            }else{
                
            }
            
            if gold == "2"{
                pick.gold = "2"
            }else if gold == "1"{
                pick.gold = "1"
            }else{
                
            }
        }
       
    }
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        filterSetup()
    }
    
    @IBAction func closeGold(_ sender: UIButton) {
        goldLabel.isHidden = true
        gold = "1"
    }
   
    @IBAction func closeOfficial(_ sender: UIButton) {
        officialLabel.isHidden = true
        official = false
    }
}

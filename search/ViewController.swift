//
//  ViewController.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 15/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import KeychainSwift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var Array = [[String]]()
    
    let key = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        //setValue()
        loadData()
        //let layout = collectionView as! UICollectionViewFlowLayout
        //layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        //layout.minimumInteritemSpacing = 5
    }
    
    func loadData(){
        var url = ""
        if key.get("max") != nil{
            url = Service().ulr(name: "Samsung", min: key.get("min")!, max: key.get("max")!, wholeshale: (key.get("wholeSale") != nil), official: (key.get("official") != nil), gold: key.get("gold")!, start: 0, row: 10)
        }else{
            url = Service().ulr(name: "Samsung", min: "10000", max: "100000", wholeshale: true, official: true, gold: "2", start: 0, row: 10)
        }
        
        Service().Registered(url: url){
            (data: DataResponse) in
            switch data.result{
            case .success(let data):
                let json = JSON(data)
                let status = json["status"]["error_code"].stringValue
                if status == "0"{
                    let total_data = json["header"]["total_data"].stringValue
                    if total_data != "0"{
                        let datas = JSON(json["data"])
                        print(datas)
                        var index = 0
                        for _ in datas{
                            let image = datas[index]["image_uri_700"].stringValue
                            let name = datas[index]["name"].stringValue
                            let price = datas[index]["price"].stringValue
                            print(image)
                            print(name)
                            print(price)
                            let array = [image, name, price]
                            self.Array.append(array)
                            index += 1
                        }
                        self.collectionView.reloadData()
                    }else{
                        print("Your data is not found")
                    }
                }else{
                    print("data error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let row = Array[indexPath.row]
        let imgURL = row[0]
        
        print(imgURL)
        let imageView = cell.picture
        imageView?.sd_setImage(with: URL(string:imgURL))
        cell.name.text = row[1]
        cell.price.text = row[2]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


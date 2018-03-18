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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var Array = [[String]]()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var totalData = 0
    
    let key = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        CollectionSetting().set(collection: collectionView)
        loadData(row: 10, lastRow: 0)
    }
    
    func loadData(row: Int, lastRow: Int){
        Service().Registered(url: Service().setUrl(row: row)){
            (data: DataResponse) in
            switch data.result{
            case .success(let data):
                let json = JSON(data)
                let status = json["status"]["error_code"].stringValue
                if status == "0"{
                    let total_data = json["header"]["total_data"].intValue
                    self.totalData = total_data
                    if total_data >= 0{
                        let datas = JSON(json["data"])
                        var datasCount = datas.count
                        var index = datasCount-1
                        for _ in datas{
                            let image = datas[index]["image_uri_700"].stringValue
                            let name = datas[index]["name"].stringValue
                            let price = datas[index]["price"].stringValue
                            let array = [image, name, price]
                            if datasCount > lastRow{
                                self.Array.append(array)
                            }
                            datasCount -= 1
                            index -= 1
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
    
    //Collection delegate
    
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
        let imageView = cell.picture
        imageView?.sd_setImage(with: URL(string:imgURL))
        cell.name.text = row[1]
        cell.price.text = row[2]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRow = Array.count - 1
        if indexPath.row == lastRow{
            if lastRow+1  < totalData{
                loadData(row: lastRow + 11, lastRow: lastRow+1)
            }
        }
    }
}


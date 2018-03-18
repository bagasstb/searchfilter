//
//  CollectionSetting.swift
//  search
//
//  Created by Satrio Teleng Bagaskoro on 18/03/18.
//  Copyright © 2018 bagas. All rights reserved.
//

import Foundation
import UIKit

class CollectionSetting{
    
    func set(collection: UICollectionView){
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width:(collection.frame.size.width - 20)/2, height : (collection.frame.size.height)/2.5)
        collection.collectionViewLayout = layout
    }
    
}

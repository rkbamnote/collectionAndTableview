//
//  Models.swift
//  collectionAndTableview
//
//  Created by Apple on 04/07/22.
//

import Foundation

class CatModel {
    var catid:  String?
    var categoryname : String?
    var shoplist : [ShopModel]
  
    init (catid: String, categoryname: String, shoplist : [ShopModel] ){
        self.catid = catid
        self.categoryname = categoryname
        self.shoplist = shoplist
    }
}



class ShopModel {
    var shop_name:  String?
    var image : String?
    var address : String?
    
  
    init (shop_name: String, image: String, address : String){
        self.shop_name = shop_name
        self.image = image
        self.address = address
       
    }
}

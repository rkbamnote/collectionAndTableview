//
//  ViewController.swift
//  collectionAndTableview
//
//  Created by Apple on 04/07/22.
//

import UIKit
//class TableViewCell: UITableViewCell {
    
class TableViewCell:UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
      var shopList = [ShopModel]()
    
    @IBOutlet var showtimesCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
       // registerCell()
            self.showtimesCollection.delegate = self
            self.showtimesCollection.dataSource = self
       
        
    }
    
//    func registerCell() {
//        showtimesCollection.register(NameCell.self, forCellWithReuseIdentifier: "collectionCell")
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! NameCell
        let data = shopList[indexPath.row]
        cell.txtName.text = data.shop_name
        cell.imgShop.downloaded(from: "https://2hrs.in/admin/uploads/vendors/"+(data.image as! String))
        cell.clipsToBounds = false
        cell.backgroundColor = .systemBackground
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.2
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    func reloadCollectionView() -> Void {
//        self.showtimesCollection.reloadData()
//    }
    @IBOutlet weak var txtCatName: UILabel!
}

class NameCell : UICollectionViewCell {
    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var txtName: UILabel!
}



class ViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
   
    var shopImageDash = [CatModel]()
    var shopList = [ShopModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clear

//        tableView.dataSource = self
//        tableView.delegate = self
//
//         // Set automatic dimensions for row height
//        tableView.rowHeight = 160
//        tableView.estimatedRowHeight = 160
        // Do any additional setup after loading the view.
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight =  UITableView.automaticDimension
        doShopsDetails()
    }


}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopImageDash.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        let data = shopImageDash[indexPath.row]
        cell.txtCatName.text = (data.categoryname ?? "" as? String)
        shopList = data.shoplist
        cell.shopList = data.shoplist
        
      //  cell.reloadCollectionView()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
  
}

//extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
//
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return 6
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! NameCell
//
//            cell.txtName.text = "Shaan"
//            print("Shaan")
//          //  let data = shopList[indexPath.row]
//
//
//
//
//
//          //  cell.shopName.text = (data.shop_name ?? "" as? String)
//
//           // print(data.shop_name)
//
//            return cell
//        }
//
//
////            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////                return CGSize(width: 100, height: 72)
////            }
//}




//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return shopList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
//
//       // cell.subjectName.text = "Selected"
//        let data = shopList[indexPath.row]
//
//
//
//
//
//      //  cell.shopName.text = (data.shop_name ?? "" as? String)
//
//        print(data.shop_name)
//
//        return cell
//    }
//
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 100, height: 72)
//        }
//
//}

extension ViewController {
func doShopsDetails(){
    let parameters: [String: Any] = ["pincode" : "440022"]

    fetchOrSendWithHeaderData(url: UrlData.getShopforCate, Parameter: parameters) { result, success, message in
        if success {
            if result["success"] as! Int == 1 {
                print("Success message done for shopsData")

                self.shopImageDash = self.parseShopData(result: result)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
//
            } else if(result["success"] as! Int == 0) {
                print("Data not found")

            } else {
                print("Result message")
            }
        } else {
            print("Network errors")
        }
    }

}
    
    
    
func parseShopData(result: NSDictionary) -> [CatModel] {
    var catList = [CatModel]()
    
    guard let data = result["data"] as? [AnyObject] else {
        return []
    }
    
//    imagePath = result["image_path"] as! String
    for item in data {
        guard let shopData = item["shopData"] as? [AnyObject] else {
            return []
        }
        var shopList = [ShopModel]()
        for itemsS in shopData {
            shopList.append(ShopModel(shop_name: itemsS["shop_name"] as? String ?? "", image: itemsS["image"] as? String ?? "", address: itemsS["address"] as? String ?? ""))
            
        }
        catList.append(CatModel(catid: item["category_id"] as? String ?? "", categoryname:  item["category_name"] as? String ?? "", shoplist: shopList))
        
        
//            shopList.append(ShopModel(catid: item["category_id"] as? String ?? "", categoryname:  item["category_name"] as? String ?? "", shopname:  item["shop_name"] as? String ?? "", shopimage:  item["image"] as? String ?? "", shopadd:  item["address"] as? String ?? ""))
    }
   
    return catList
  
}
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

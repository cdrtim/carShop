//
//  ViewController.swift
//  autoShop
//
//  Created by Pham Ngoc Hai on 12/21/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var item: [items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        
        
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.black
        var myDics: NSDictionary?
        if let path = Bundle.main.path(forResource: "items", ofType: "plist")
        {
        myDics = NSDictionary(contentsOfFile: path)
        }
        for dic in myDics!.allValues as! [NSDictionary]
        {
        item.append(items.init(name: dic["name"] as! String, content: dic["content"] as! String, nameImages: dic["images"] as! NSArray as! [String], price: dic["price"] as! String))
        }
        
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellItem
        cell.addSubviews(true)
        cell.imageView.image = UIImage(named: item[indexPath.item].nameImages[0]+".jpg")
        cell.nameLabel.text = item[indexPath.item].name
        cell.price.text = item[indexPath.item].price
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewDetail") as? ViewDetail
        listView?.item = item[indexPath.item]
        self.navigationController?.pushViewController(listView!, animated: true)
        
    }


}

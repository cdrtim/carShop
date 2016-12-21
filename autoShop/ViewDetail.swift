//
//  ViewDetail.swift
//  autoShop
//
//  Created by Pham Ngoc Hai on 12/21/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class ViewDetail: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var nameShop: UILabel!

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var detailShop: UITextView!
    var item : items!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = item.name
        nameShop.text = item.name
        detailShop.text = item.content
        imgProfile.image = UIImage(named: item.nameImages[0])
    //    print(item.nameImages[0]+".jpg")
        imgProfile.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewDetail.tapImg))
        imgProfile.addGestureRecognizer(tap)
           }
    func tapImg()
    {
        pushView(0)
    }
    func pushView(_ index: Int)
    {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as? ViewScroll
        listView?.pageImages = item.nameImages
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
    //    delegate uicollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.nameImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellItem
        cell.kCellWidth = 100
        cell.addSubviews(false)
        cell.imageView.image = UIImage(named: item.nameImages[indexPath.item]+".jpg")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushView(indexPath.item)
        
    }
}

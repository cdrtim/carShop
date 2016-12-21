//
//  ViewScroll.swift
//  autoShop
//
//  Created by Pham Ngoc Hai on 12/21/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var carName: UILabel!
    var item : items!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var viewScroll: UIScrollView!
    var photos: [UIImageView] = []
    var pageImages: [String] =  []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //THuoc tinh lam cho thanh tung anh tren tung view
        viewScroll.isPagingEnabled = true
        let fileName : NSString = pageImages[currentPage] as NSString
        let name = fileName.deletingPathExtension
        navigationItem.title = name
    
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        if (!first)
        {
            first = true
            let pagesScrollViewSize = viewScroll.frame.size
            viewScroll.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0)
            viewScroll.contentOffset = CGPoint(x: CGFloat(currentPage) * viewScroll.frame.size.width, y: 0)
            
            for i in 0 ..< pageImages.count
            {
                
                let imgView = UIImageView(image: UIImage(named:pageImages[i]+".jpg"))
                print(pageImages[i])
                imgView.frame = CGRect(x: 0, y: 0, width: viewScroll.frame.size.width, height: viewScroll.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.doubleTabImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.require(toFail: doubleTap)
                photos.append(imgView)
                let frontScrollView = UIScrollView(frame: CGRect( x: CGFloat(i) * viewScroll.frame.size.width, y: 0, width: viewScroll.frame.size.width, height: viewScroll.frame.size.height))
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollView.contentSize = imgView.bounds.size
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                self.viewScroll.addSubview(frontScrollView)
//
            }
            
        }
        
    }
    
    func tapImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: photos[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 1.5, center: position)
    }
    func doubleTabImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: photos[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = viewScroll.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollViews[pageController.currentPage] .zoom(to: zoomRect, animated: true)
    }
    //uiscrollview delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return photos[pageController.currentPage]
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((self.viewScroll.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        //
        
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        if (pageController.currentPage != page)
        {
          
            //                let theFileName: NSString = item.nameImages[0] as NSString
            //
            //                let name =  theFileName.deletingPathExtension
            //                carName.text = name
            //       frontScrollViews[pageController.currentPage].zoomScale = 1
            pageController.currentPage = page
        }
        
        let fileName : NSString = pageImages[page] as NSString
        let name = fileName.deletingPathExtension
        navigationItem.title = name
    
    
    }
    
}




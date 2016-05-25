//
//  ExploreCVC.swift
//  Instagram
//
//  Created by Emre Sasmaz on 5/25/16.
//  Copyright © 2016 Emre Sasmaz. All rights reserved.
//

import UIKit
import SimpleAuth

class ExploreCVC: UICollectionViewController {
    
    private let leftAndRightPaddings: CGFloat = 32.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    private let heightAdjustment: CGFloat = 30.0
    
    struct Storyboard {
        static let explorePhotoCell = "ExplorePhotoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure the collection view
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        //configure the view
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings) / numberOfItemsPerRow        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
        
        
        SimpleAuth.authorize("instagram") {
            (responseObject, error) -> Void in
            print(responseObject)
        }
       // authInstagram()
    }
//    private var accessToken: String!
//    private let ACCESS_TOKEN_STR: String = "accessToken"
//    func authInstagram() {
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        if let token = userDefaults.objectForKey(self.ACCESS_TOKEN_STR) as? String {
//            
//            self.accessToken = token
//            print(accessToken)
//            
//            //start fetching photos
//           // fetchPhotos()
//            
//        } else {
//            
//            SimpleAuth.authorize("instagram") {
//                (responseObject, error) -> Void in
//                if let resposne = responseObject as? NSDictionary {
//                    let credentials = resposne["credentials"] as! NSDictionary
//                    let accessToken = credentials["token"] as! String
//                    self.accessToken = accessToken
//                    
//                    userDefaults.setObject(self.accessToken, forKey: self.ACCESS_TOKEN_STR)
//                    userDefaults.synchronize()
//                    
//                  //  self.fetchPhotos()
//                }
//            }
//        }
//    }

    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.explorePhotoCell, forIndexPath: indexPath) as! ExploreCollectionViewCell
        
        cell.imageView.image = UIImage(named : "noimages")
        
        
        return cell
        
        
    }
}

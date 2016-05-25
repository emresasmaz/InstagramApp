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
    private var accessToken: String!
    
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
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let token = userDefaults.objectForKey("accessToken") as? String {
            print("Log In")
            self.accessToken = token
            print(accessToken)
            
        } else {
            
            SimpleAuth.authorize("instagram") {
                (responseObject, error) -> Void in
                if let response = responseObject as? NSDictionary {
                    let credentials = response["credentials"] as! NSDictionary
                    let accessToken = credentials["token"] as! String
                    self.accessToken = accessToken
                    
                    userDefaults.setObject(self.accessToken, forKey: "accessToken")
                    userDefaults.synchronize()
                    
                }
            }
        }
    }
    
    //https://api.instagram.com/v1/tags/{tag-name}/media/recent?access_token=ACCESS-TOKEN
    
    func urlWithSearchText(searchText: String) -> NSURL {
        let espacedSearchText = searchText.stringByReplacingOccurrencesOfString(" ", withString: "")
        let urlString = "https://api.instagram.com/v1/tags/\(espacedSearchText)/media/recent?access_token=\(self.accessToken)"
        
        let url = NSURL(string: urlString)!
        return url
    }

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

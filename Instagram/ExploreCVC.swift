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
        
        
        SimpleAuth.authorize("instagram") { (responseObject, error) -> Void in
            print(responseObject)
        }

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

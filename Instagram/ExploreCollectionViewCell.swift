//
//  ExploreCollectionViewCell.swift
//  Instagram
//
//  Created by Emre Sasmaz on 5/25/16.
//  Copyright © 2016 Emre Sasmaz. All rights reserved.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesCount: UILabel!
    
    var photo: AnyObject! {
        didSet{
            InstagramData.imageForPhoto(photo, size: "thumbnail") { (image) -> Void in
                self.imageView.image = image
            }
        }
    }
    
}


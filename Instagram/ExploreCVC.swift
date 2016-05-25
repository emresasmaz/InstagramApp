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
    @IBOutlet var searchBar: UISearchBar!
    private var accessToken: String!
    private var photoDictionaries = [AnyObject]()
    private var data:[[String: String!]] = []
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
        auth()
    }
    
    func auth(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let token = userDefaults.objectForKey("accessToken") as? String {
            print("Log In")
            self.accessToken = token
            print(accessToken)
            self.fetchPhotos()
        } else {
            
            SimpleAuth.authorize("instagram") {
                (responseObject, error) -> Void in
                if let response = responseObject as? NSDictionary {
                    let credentials = response["credentials"] as! NSDictionary
                    let accessToken = credentials["token"] as! String
                    self.accessToken = accessToken
                    
                    userDefaults.setObject(self.accessToken, forKey: "accessToken")
                    userDefaults.synchronize()
                    self.fetchPhotos()
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
    
        func fetchPhotos() {
            //get the session first
            let session = NSURLSession.sharedSession()
            let searchText = self.searchBar.text!
            let url: NSURL
    
            if !searchText.isEmpty {
                url = urlWithSearchText(searchText)
            } else {
                url = urlWithSearchText("istanbul")
            }
            //create a request for fetching from server
            let request = NSURLRequest(URL: url)
    
            let task = session.downloadTaskWithRequest(request) { (localFile, response, error) -> Void in
                if error == nil { //no errors in the request
                    let data = NSData(contentsOfURL: localFile!) //received data
                    //parse json with NSJSON serializer
                    do{
                        let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data! , options: NSJSONReadingOptions.AllowFragments)
    
                        self.photoDictionaries = responseDictionary.valueForKey("data") as! [AnyObject]
                        print(self.photoDictionaries)
                        
    
                    } catch let error{
                        print(error)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView?.reloadData()
                })
                
            }
            task.resume()
        }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoDictionaries.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.explorePhotoCell, forIndexPath: indexPath) as! ExploreCollectionViewCell
        
        let photoDictionary = photoDictionaries[indexPath.item]
        cell.photo = photoDictionary
        return cell
        
        
    }
}

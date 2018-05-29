//
//  ViewController.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/29/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeScreen: UIViewController {
    var ItemList : [PhotoItem] = []
    var lastItem = 0
    let offset   = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServiceHandler().getPhotos(delegate: self)
    }

}

extension HomeScreen : DataFetcherProtocol {
    func onDataReady(_data: AnyObject, url: String) {
        let json = JSON (_data)
        if url == ServiceHandler().BASE_URL+ServiceHandler().URL_GetPhotos {
            var itemCounter = 0
            let threshold = lastItem + offset
            for (_,subJson):(String, JSON) in json {
                itemCounter += 1
                if itemCounter < lastItem {
                    continue
                } else if itemCounter > threshold {
                    break
                }
                else {
                        let newItem = PhotoItem(albumId: subJson["albumId"].intValue, id: subJson["id"].intValue, title: subJson["title"].stringValue, photoUrl: subJson["url"].stringValue, thumbnailUrl: subJson["thumbnailUrl"].stringValue)
                        ItemList.append(newItem)
                }
            }
        }
    }
 
    func onError(_error: Error) {
        print (_error)
    }
    
    
}


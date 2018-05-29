//
//  WebService.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/29/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//


import Foundation
import Alamofire

class WebService {
    var url : String!
    var params : Parameters
    var fetchDelegate : DataFetcherProtocol!
    
    init(url : String, params : Parameters ,fetchDelegate : DataFetcherProtocol!) {
        self.url = url
        self.params = params
        self.fetchDelegate = fetchDelegate
    }
    
    func get()  {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: .get, parameters: params ).responseJSON { (response ) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result
            {
            case .success(let _data):
                self.fetchDelegate.onDataReady(_data: _data as AnyObject , url : self.url)
            case .failure(let error):
                self.fetchDelegate.onError(_error: error)
            }
        }
    }
    
    func post()  {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
         Alamofire.request(url, method: .post, parameters: params ,  encoding: JSONEncoding.default ).responseJSON { (response ) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result
            {
            case .success(let _data):
                self.fetchDelegate.onDataReady(_data: _data as AnyObject , url : self.url)
            case .failure(let error):
                self.fetchDelegate.onError(_error: error)
            }
        }
    }
}

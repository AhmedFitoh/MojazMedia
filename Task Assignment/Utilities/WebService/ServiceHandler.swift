//
//  ServiceHandler.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/29/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//


import Foundation

class ServiceHandler{
    
 
    lazy var BASE_URL = "https://jsonplaceholder.typicode.com/"
    lazy var URL_GetPhotos = "photos"
  
    func getPhotos ( delegate:DataFetcherProtocol){
        let service =  WebService.init(url: BASE_URL+URL_GetPhotos, params: [:], fetchDelegate: delegate)
        service.get()
    }


    
}

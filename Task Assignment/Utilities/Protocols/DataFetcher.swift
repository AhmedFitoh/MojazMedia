//
//  DataFetcher.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/29/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//

import Foundation

protocol DataFetcherProtocol {
    func onDataReady(_data : AnyObject , url : String)
    func onError(_error:Error)
}

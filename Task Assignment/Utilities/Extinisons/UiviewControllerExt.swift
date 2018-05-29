//
//  UiviewControllerExt.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/30/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func viewAlert(msg:String){
        let alert = UIAlertController(title: "Mojaz Task", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


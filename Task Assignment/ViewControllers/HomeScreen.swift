//
//  ViewController.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/29/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeScreen: UIViewController  , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var itemTable: UITableView!

    
    var ItemList : [PhotoItem] = []
    var selectedItems : [PhotoItem] = []
    var lastItem = 0
    let offset   = 20
    var filterdScreen = false
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }

    func loadItems (){
        if !filterdScreen {
            ServiceHandler().getPhotos(delegate: self)
        }

    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        if selectedItems.isEmpty {
            // show message
            return
        }
        let nextVc = storyboard?.instantiateViewController(withIdentifier: "homeScreen") as! HomeScreen
        nextVc.filterdScreen = true ; nextVc.ItemList = self.selectedItems
        navigationController?.pushViewController(nextVc, animated: true)
        
    }
    
    // Mark:- TableView DataSource & Delegate
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemCell
        cell.setCell(item: ItemList [indexPath.row], selected: isCellSelected(itemId: ItemList[indexPath.row].id), showSelection: !filterdScreen)
        return cell
    }
    func isCellSelected (itemId : Int) -> Bool {
        let temp = selectedItems.filter { (item) -> Bool in
            if item.id == itemId
            {
                return true
            }
            return false
        }
        if temp.isEmpty {
            return false
        }else {
            return true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let itemId = ItemList[indexPath.row].id
        let cell = tableView.cellForRow(at: indexPath) as! ItemCell
        if cell.selectPic.image == #imageLiteral(resourceName: "unchecked") {
            if selectedItems.count == 10 {
                // show message to the user
                return
            }
            cell.selectPic.image = #imageLiteral(resourceName: "check_red")
            selectedItems.append(ItemList [indexPath.row])
        } else {
          cell.selectPic.image = #imageLiteral(resourceName: "unchecked")
          selectedItems = selectedItems.filter { (item) -> Bool in
                if item.id == itemId {
                    return false
                }
                return true
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !filterdScreen {
            if indexPath.row == lastItem - 1 {
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
                spinner.startAnimating()
                self.loadItems()
            }
        }
       
    }
}

extension HomeScreen : DataFetcherProtocol {
    func onDataReady(_data: AnyObject, url: String) {
        var json = JSON (_data)
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
                        lastItem += 1
                }
            }
            json = JSON.null
            spinner.stopAnimating()
            itemTable.reloadData()
        }
    }
 
    func onError(_error: Error) {
        print (_error)
    }
    
    
}


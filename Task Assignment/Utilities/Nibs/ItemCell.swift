//
//  ItemCell.swift
//  Task Assignment
//
//  Created by Ahmed Fitoh on 5/29/18.
//  Copyright © 2018 mojazapp. All rights reserved.
//

import UIKit
import SDWebImage
class ItemCell: UITableViewCell {

    @IBOutlet weak var Pic: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell (item : PhotoItem) {
        titleLBL.text = item.title
        let imageURL : URL = URL (string: item.thumbnailUrl)!
        Pic.sd_setImage(with: imageURL, completed: nil)
        Pic.layer.cornerRadius = 10
    }

}

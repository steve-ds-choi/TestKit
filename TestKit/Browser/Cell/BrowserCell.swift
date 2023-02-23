//
//  BrowserCell.swift
//  TestKit
//
//  Created by steve on 2023/02/17.
//

import UIKit
import Kingfisher

class BrowserCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var thumb: UIImageView!
    
    func load(_ item: Item) {        
        thumb.kf.setImage(with: item.Ithumb.asURL)

        titleLabel.text    = item.Ititle
        subtitleLabel.text = item.Isubtitle
        priceLabel.text    = item.Iprice

        subtitleLabel.isHidden = item.Isubtitle.count == 0
    }
}

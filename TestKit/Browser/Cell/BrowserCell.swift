//
//  BrowserCell.swift
//  TestKit
//
//  Created by steve on 2023/02/17.
//

import UIKit
import Kingfisher
import SnapKit

class BrowserCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var thumb: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        stackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing
                .equalToSuperview().offset(2)
        }
    }

    func load(_ item: Item) {        
        thumb.kf.setImage(with: item.Ithumb.asURL)

        titleLabel.text    = item.Ititle
        subtitleLabel.text = item.Isubtitle
        priceLabel.text    = item.Iprice

        subtitleLabel.isHidden = item.Isubtitle.count == 0
    }
}

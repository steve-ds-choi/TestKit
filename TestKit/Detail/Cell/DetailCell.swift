//
//  DetailCell.swift
//  TestKit
//
//  Created by steve on 2023/02/19.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    func load(_ item: CellItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
}

//
//  DetailCell.swift
//  TestKit
//
//  Created by steve on 2023/02/19.
//

import UIKit
import SnapKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(6)
            $0.top.bottom.equalToSuperview().offset(10)
        }
    }

    func load(_ item: CellItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
}

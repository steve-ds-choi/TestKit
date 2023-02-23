//
//  DetailController.swift
//  TestKit
//
//  Created by steve on 2023/02/17.
//

import UIKit
import Then

class CellItem {
    var title = ""
    var detail = ""
}

class DetailController: TKViewController {
    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var item: Item!
    var list = [CellItem]()

    private var thumbH = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbH = thumbView.h
        tableView.registerCell(DetailCell.self)
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        navigationPop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItem()
    }
}

extension DetailController {
 
    private func beg() {
        tableView.contentOffset = CGPoint.zero
        imageView.kf.setImage(with: item.Ithumb.asURL, placeholder: UIImage(named:"photo.circle"))
        list.removeAll()
    }
    
    private func end() {
        tableView.reloadData()
    }
    
    private func set(_ title: String, detail: String) {
        let item = CellItem()
        item.title = title
        item.detail = detail.htmlDecoded
        
        list.append(item)
    }
    
    private func loadItem() {
        
        beg()
        
        set("Title",     detail: item.Ititle)
        set("Subtitle",  detail: item.Isubtitle)
        set("Desc",      detail: item.Idesc)

        set("-",         detail: "-")

        set("Author",    detail: item.Iauthors)
        set("Publisher", detail: item.Ipublisher)
        set("Price",     detail: item.Iprice)

        end()
    }
}

extension DetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        return tableView.dequeueCell(DetailCell.self).then {
            $0.load(item)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y < 0 { thumbView.h = thumbH - offset.y }
    }
}

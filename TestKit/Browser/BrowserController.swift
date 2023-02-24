//
//  BrowserController.swift
//  TestKit
//
//  Created by steve on 2023/02/17.
//

import UIKit
import Combine
import SnapKit

class BrowserController: TKViewController {

    private let vm = ViewModel()
    private var list = [Item]()
    private var bags = Set<AnyCancellable>()

    private let detailController = DetailController()

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    
    private var rowForReload = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        loadLayout()
        loadTable()
        
        bindControl()
        bindModel()
    }
}

extension BrowserController {

    private func loadLayout() {
        titleView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
    }

    private func loadTable() {
        tableView.registerCell(BrowserCell.self)
    }

    private func reload() {
        if list.count > 0 {
            rowForReload = list.count - 4
        }

        tableView.reloadData()
    }

    private func bindControl() {
        textField.publisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink {
                self.vm.searchText($0)
            }
            .store(in: &bags)
    }

    private func bindModel() {
        vm.$list
            .sink {
                self.list = $0
                self.reload()
            }
            .store(in: &bags)

        vm.$body
            .sink {
                self.showDetail($0)
            }
            .store(in: &bags)
    }
}

extension BrowserController: UITableViewDelegate, UITableViewDataSource {

    func showDetail(_ item: Item?) {
        guard let item else { return }

        detailController.item = item
        navigationPush(page: detailController)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        return tableView.dequeueCell(BrowserCell.self).then {
            $0.load(item)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= rowForReload {
            rowForReload = -1
            vm.searchNext()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        vm.requestBody(item)
    }
}

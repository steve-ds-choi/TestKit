//
//  BrowserController.swift
//  TestKit
//
//  Created by steve on 2023/02/17.
//

import UIKit
import Combine

class BrowserController: TKViewController {

    private let vm = ViewModel()
    private var list = [Item]()
    private var bags = Set<AnyCancellable>()

    private let detailController = DetailController()

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private var rowForReload = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTable()

        bindControl()
        bindModel()
    }
}

extension BrowserController {

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
        let cell = tableView.dequeueCell(BrowserCell.self)

        cell.load(item)

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= rowForReload {
            rowForReload = -1
            vm.searchNext()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        vm.requestBody(item) {
            self.showDetail($0)
        }
    }
}

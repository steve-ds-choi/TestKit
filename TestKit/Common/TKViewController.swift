//
//  TKViewController.swift
//  TestKit
//
//  Created by steve on 2023/02/16.
//

import UIKit

class TKViewController: UIViewController {

    func navigationPush(root: TKViewController) {

        let navigation = UINavigationController(rootViewController: root)

        navigation.isNavigationBarHidden = true
        navigation.view.frame = view.bounds
        navigation.view.autoresizingMask = .All

        view.insertSubview(navigation.view, at:0)
        addChild(navigation)
    }

    func navigationPush(page: TKViewController) {
        navigationController?.pushViewController(page, animated: true)
    }
    
    func navigationPop() {
        navigationController?.popViewController(animated: true)
    }

    func navigationPush(detail: TKViewController) {
        navigationController?.showDetailViewController(detail, sender:nil)
    }
}

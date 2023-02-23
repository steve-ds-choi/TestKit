//
//  ViewController.swift
//  TestKit
//
//  Created by steve on 2023/02/15.
//

import UIKit
import Combine

class ViewController: TKViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationPush(root: BrowserController())
    }
}


//
//  ViewController.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/12.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ApiManager().postsData
            .subscribe({  print($0.element![0].title) })
    }
}


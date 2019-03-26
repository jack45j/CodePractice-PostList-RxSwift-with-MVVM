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

class MainListViewController: UIViewController {
    
    var tableView: UITableView?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articles"
        
        tableView = UITableView(frame: self.view.frame, style: .plain)
        configure(tableView: tableView!)
        
        tableView!.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
        ApiManager().postsData
            .bind(to: tableView!.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: row, section: 0)) as! DetailTableViewCell
                cell.configure(viewModel: DetailCellViewModel(post: element))
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension MainListViewController: UIScrollViewDelegate, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize.width = 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222+12
    }
}

extension MainListViewController {
    
    func configure(tableView: UITableView) {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 6, right: 0)
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
    }
}


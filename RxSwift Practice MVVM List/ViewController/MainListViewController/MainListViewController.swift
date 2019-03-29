//
//  ViewController.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/12.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainListViewController: UIViewController {
    
    var viewModel: PostsViewModel!
    
    lazy var tableView = UITableView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Articles"
        
        configure(tableView: tableView)
        
        bindViewModel()
    }
    
    init(viewModel: PostsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        let input = PostsViewModel.Input(ready: rx.viewWillAppear.asDriver())
        let output = viewModel.transform(input: input)
        
        output.posts
            .drive(tableView.rx.items(
                cellIdentifier: "Cell", cellType: CardsTableViewCell.self)) { (row, viewModel, cell) in
                cell.configure(viewModel: viewModel)
                
                cell.cardView.cardFooterView.commentIconButton.rx.tap
                    .subscribe(
                        onNext: { _ in
                            print("tableview \(row) commentIconButton pressed.")
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.cardView.cardFooterView.commentButton.rx.tap
                    .subscribe(
                        onNext: { _ in
                            print("tableview \(row) commentButton pressed.")
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}

extension MainListViewController {
    
    func configure(tableView: UITableView) {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 6, right: 0)
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(CardsTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        /// Is it better to make constraints in another view or viewModel?
        /// And how?
        tableView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.left.right.equalTo(0)
        }
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension MainListViewController: UIScrollViewDelegate, UITableViewDelegate {
    
    /// Prevent tableView from horizontal scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize.width = 0
    }
    
    /// Is it acceptable to put this protocol in ViewController?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222+12
    }
}
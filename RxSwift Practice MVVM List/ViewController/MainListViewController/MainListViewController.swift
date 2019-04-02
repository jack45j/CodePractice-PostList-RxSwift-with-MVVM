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
    
    var postsViewModel: PostsViewModel!
    
    lazy var tableView = UITableView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Articles"
        
        configure(tableView: tableView)
        
        bindViewModel()
    }
    
    init(postViewModel: PostsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.postsViewModel = postViewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        let postsInput = PostsViewModel.Input(initial: rx.viewWillAppear.asDriver())
        let postsOutput = postsViewModel.transform(input: postsInput)
                    
        postsOutput.posts
            .drive(tableView.rx.items(
                cellIdentifier: "Cell", cellType: CardsTableViewCell.self)) { (row, viewModel, cell) in
                    cell.configure(viewModel: viewModel)
                    
                    postsOutput.comments.asObservable()
                        .map{ "\($0.filter({ $0.postId == row+1 }).count) comments" }
                        .bind(to: cell.cardView.cardFooterView.commentButton.rx.title(for: .normal))
                        .disposed(by: self.disposeBag)
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

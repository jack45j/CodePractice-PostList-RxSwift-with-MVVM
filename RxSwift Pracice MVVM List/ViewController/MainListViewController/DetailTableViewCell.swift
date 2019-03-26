//
//  DetailTableViewCell.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/14.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailTableViewCell: UITableViewCell {
    
    var postData: PublishSubject<Post>?
    
    var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configure(viewModel: DetailCellViewModel) {
        if cardView == nil {
            cardView = CardView()
            cardView.cardHeaderView.titleLabel.text = viewModel.title
            cardView.cardHeaderView.dateTitleLabel.text = "12 Nov 2019"
            cardView.cardBodyView.postTitleLabel.text = viewModel.title
            cardView.cardBodyView.postBodyLabel.text = viewModel.body
            self.addSubview(cardView)
            
            cardView.snp.makeConstraints { (constraint) in
                constraint.left.equalTo(16)
                constraint.top.equalTo(6)
                constraint.height.equalTo(222)
                constraint.right.equalTo(-16)
            }
        }
    }
}


extension DetailTableViewCell {
    
}
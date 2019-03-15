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
    
    var postData: Variable<Post>?
    
    lazy var cardView = UIView()
    lazy var titleLabel = UILabel()
    lazy var summaryLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI() {
        self.addSubview(cardView)
        configureCardView()
        cardView.addSubview(titleLabel)
        configureTitleLabel()
        
        
        let title = Variable(postData?.value.title)
        title.asObservable()
            .bind(to: titleLabel.rx.text)
            .disposed(by: DisposeBag())
    }
}


extension DetailTableViewCell {
    
    func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.numberOfLines = 1
        titleLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(0)
            constraint.height.equalTo(60)
            constraint.left.equalTo(16)
            constraint.right.equalTo(-16)
        }
    }
    
    func configureCardView() {
        cardView.backgroundColor = UIColor.white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardView.addSubview(titleLabel)
        cardView.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(16)
            constraint.height.equalTo(220)
            constraint.right.equalTo(-16)
        }
    }
}

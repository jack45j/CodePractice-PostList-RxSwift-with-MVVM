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
    
    /// MARK: - UI element
//    lazy var cardView = UIView()
    lazy var titleLabel = UILabel()
    lazy var summaryLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configure(viewModel: DetailCellViewModel) {
        if cardView == nil {
            cardView = CardView()
            cardView.titleLabel.text = viewModel.title
            cardView.dateTitleLabel.text = "12 NOV 2019"
            self.addSubview(cardView)
            
            cardView.snp.makeConstraints { (constraint) in
                constraint.left.equalTo(16)
                constraint.top.equalTo(6)
                constraint.bottom.equalTo(-6)
                constraint.right.equalTo(-16)
            }
        }
    }
}


extension DetailTableViewCell {
    
}

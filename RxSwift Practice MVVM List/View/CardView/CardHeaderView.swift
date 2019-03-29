//
//  CardHeaderView.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/26.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit

class CardHeaderView: UIView {
    
    /// UI Elements
    lazy var thumbnailImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var dateTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCardHeaderView() {
        CardHeaderViewLog("Start init view")
        
        titleLabel.numberOfLines = 1
        
        thumbnailImageView.image = UIImage(named: "myKitty")
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        
        dateTitleLabel.font = UIFont.systemFont(ofSize: 13)
        dateTitleLabel.textColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        dateTitleLabel.textAlignment = .right
    }
    
    override func layoutSubviews() {
        CardHeaderViewLog("Start layoutSubviews")
        
        let cardHeaderView = UIStackView(arrangedSubviews: [thumbnailImageView, titleLabel, dateTitleLabel])
        cardHeaderView.axis = .horizontal
        cardHeaderView.alignment = .center
        cardHeaderView.spacing = 12
        
        self.addSubview(cardHeaderView)
        cardHeaderView.snp.makeConstraints { (constraint) in
            constraint.bottom.equalTo(-12)
            constraint.top.left.right.equalTo(0)
            constraint.height.equalTo(36)
        }
        
        thumbnailImageView.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(0)
            constraint.width.equalTo(thumbnailImageView.snp.height)
        }
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width/2
        thumbnailImageView.layoutIfNeeded()
        
        titleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
        }
        
        dateTitleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.width.equalTo(86)
        }
        
        let headerSeparator = UIView()
        cardHeaderView.addSubview(headerSeparator)
        headerSeparator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        headerSeparator.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.centerY.equalTo(self.snp.bottom)
            constraint.height.equalTo(1)
        }
        
        CardHeaderViewLog("Finishing layoutSubviews")
    }
}

private struct CardHeaderViewLog {
    @discardableResult
    init(_ message: String, sendToSlack: Bool = false) {
        CardViewLog(message, view: "CardHeaderView", sendToSlack: sendToSlack)
    }
}

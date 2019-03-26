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
    ///
    let thumbnailImageContainerView = UIView()
    lazy var thumbnailImageView = UIImageView()
    
    let titleContainerView = UIView()
    lazy var titleLabel = UILabel()
    
    let dateContainerView = UIView()
    lazy var dateTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCardHeaderView()
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
        
        let cardHeaderView = UIStackView(arrangedSubviews: [thumbnailImageContainerView, titleContainerView, dateContainerView])
        cardHeaderView.axis = .horizontal
        cardHeaderView.spacing = 12
        
        CardHeaderViewLog("Making cardHeaderView constraints")
        self.addSubview(cardHeaderView)
        cardHeaderView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.left.equalTo(12)
            constraint.right.equalTo(-12)
            constraint.height.equalTo(60)
        }
        
        CardHeaderViewLog("Making thumbnailImageContainerView constraints")
        thumbnailImageContainerView.addSubview(thumbnailImageView)
        thumbnailImageContainerView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.width.equalTo(thumbnailImageContainerView.snp.height).offset(-24)
        }
        
        CardHeaderViewLog("Making thumbnailImageView constraints")
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width/2
        thumbnailImageView.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(0)
            constraint.top.equalTo(12)
            constraint.bottom.equalTo(-12)
            constraint.width.equalTo(thumbnailImageView.snp.height)
        }
        
        CardHeaderViewLog("Making dateContainerView constraints")
        dateContainerView.addSubview(dateTitleLabel)
        dateContainerView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.width.equalTo(98)
        }
        
        CardHeaderViewLog("Making dateTitleLabel constraints")
        dateTitleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.left.equalTo(0)
            constraint.right.equalTo(-12)
        }
        
        CardHeaderViewLog("Making titleContainerView constraints")
        titleContainerView.addSubview(titleLabel)
        titleContainerView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
        }
        
        CardHeaderViewLog("Making titleLabel constraints")
        titleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.left.right.equalTo(0)
        }
        
        CardHeaderViewLog("Making headerSeparator constraints")
        let headerSeparator = UIView()
        cardHeaderView.addSubview(headerSeparator)
        headerSeparator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        headerSeparator.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.centerY.equalTo(cardHeaderView.snp.bottom)
            constraint.height.equalTo(1)
        }
        
        CardHeaderViewLog("Finishing layoutSubviews")
    }
}

private struct CardHeaderViewLog {
    @discardableResult
    init(_ message: String) {
        CardViewLog(message, view: "CardHeaderView")
    }
}

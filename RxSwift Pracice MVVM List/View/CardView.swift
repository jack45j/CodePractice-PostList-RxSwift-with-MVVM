//
//  CardView.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/25.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit
import SnapKit

class CardView: UIView {
    
    let titleContainerView = UIView()
    lazy var titleLabel = UILabel()
    
    let thumbnailImageContainerView = UIView()
    lazy var thumbnailImageView = UIImageView()
    
    let dateContainerView = UIView()
    lazy var dateTitleLabel = UILabel()
    
    lazy var postTitle = UILabel()
    
    lazy var postBody = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateUI()
    }
    
    override func layoutSubviews() {
        configureCardView()
        
        titleLabel.numberOfLines = 1
        
        thumbnailImageView.image = UIImage(named: "myKitty")
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width/2
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        
        dateTitleLabel.font = UIFont.systemFont(ofSize: 13)
        dateTitleLabel.textColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        dateTitleLabel.textAlignment = .right
    }
    
    func configureCardView() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
        
        
        /// add custom shadows to card view
        let firstShadow = CALayer()
        firstShadow.frame = self.bounds
        firstShadow.cornerRadius = 8
        firstShadow.shadowRadius = 1
        firstShadow.backgroundColor = UIColor.white.cgColor
        firstShadow.shadowOffset = CGSize(width: 0, height: 1)
        firstShadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.18).cgColor
        firstShadow.shadowOpacity = 1
        
        let secondShadow = CALayer()
        secondShadow.frame = self.bounds
        secondShadow.cornerRadius = 8
        secondShadow.shadowRadius = 0
        secondShadow.backgroundColor = UIColor.white.cgColor
        secondShadow.shadowOffset = CGSize(width: 0, height: 1)
        secondShadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        secondShadow.shadowOpacity = 1
        
        let thirdShadow = CALayer()
        thirdShadow.frame = self.bounds
        thirdShadow.cornerRadius = 8
        thirdShadow.shadowRadius = 0
        thirdShadow.backgroundColor = UIColor.white.cgColor
        thirdShadow.shadowOffset = CGSize(width: 0, height: 2)
        thirdShadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        thirdShadow.shadowOpacity = 1
        
        self.layer.insertSublayer(firstShadow, at: 0)
        self.layer.insertSublayer(secondShadow, below: firstShadow)
        self.layer.insertSublayer(thirdShadow, below: secondShadow)
    }
    
    func updateUI() {
        configureHeaderView()
    }
    
    func configureHeaderView() {
        let cardHeaderView = UIStackView(arrangedSubviews: [thumbnailImageContainerView,
                                                            titleContainerView,
                                                            dateContainerView])
        self.addSubview(cardHeaderView)
        
        cardHeaderView.backgroundColor = UIColor.blue
        cardHeaderView.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.height.equalTo(60)
        }
        
        let headerSeparator = UIView()
        cardHeaderView.addSubview(headerSeparator)
        headerSeparator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        headerSeparator.snp.makeConstraints { (constraint) in
            constraint.height.equalTo(1)
            constraint.left.equalTo(12)
            constraint.right.equalTo(-12)
            constraint.centerY.equalTo(cardHeaderView.snp.bottom)
        }
        
        thumbnailImageContainerView.addSubview(thumbnailImageView)
        thumbnailImageContainerView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.width.equalTo(thumbnailImageContainerView.snp.height)
        }
        
        thumbnailImageView.snp.makeConstraints { (constraint) in
            constraint.top.left.equalTo(12)
            constraint.bottom.equalTo(-12)
            constraint.width.equalTo(thumbnailImageView.snp.height)
        }
        
        
        titleContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.left.equalTo(0)
            constraint.right.equalTo(-12)
        }
        
        dateContainerView.addSubview(dateTitleLabel)
        dateContainerView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.width.equalTo(98)
        }
        
        dateTitleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.left.equalTo(0)
            constraint.right.equalTo(-12)
        }
    }
}

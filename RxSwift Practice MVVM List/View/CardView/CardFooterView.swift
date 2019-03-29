//
//  CardFooterView.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/26.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit

class CardFooterView: UIView {
    
    /// UI Elements
    lazy var commenterStackView = UIStackView()
    lazy var commentersImage = [UIImage]()
    
    lazy var commentButton = UIButton()
    lazy var commentIconButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCardFooterView() {
        
        CardFooterViewLog("Start init view")
        
        commenterStackView.spacing = -10
        commenterStackView.axis = .horizontal
        
        #warning("will add arranged subview according to commentersImage count and limit mac amount to 3 images.")
        for _ in 0...2 {
            commenterStackView.addArrangedSubview(UIImageView())
        }
        
        commentButton.setTitle("30 comments", for: .normal)
        commentButton.setTitleColor(UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1), for: .normal)
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        commentButton.contentHorizontalAlignment = .left
        
        commentIconButton.setImage(UIImage(named: "talkIcon"), for: .normal)
    }
    
    override func layoutSubviews() {
        
        CardFooterViewLog("Start layoutSubviews")
        
        let cardFooterView = UIStackView(arrangedSubviews: [commenterStackView, commentButton])
        cardFooterView.axis = .horizontal
        cardFooterView.spacing = 6
        self.addSubview(cardFooterView)
        
        cardFooterView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(12)
            constraint.left.right.bottom.equalTo(0)
            constraint.height.equalTo(20)
        }
        
        commenterStackView.snp.makeConstraints { (constraint) in
            constraint.top.left.bottom.equalTo(0)
        }
        
        commenterStackView.arrangedSubviews.forEach { (view) in
            view.snp.makeConstraints({ (constraint) in
                constraint.top.bottom.equalTo(0)
                constraint.width.equalTo(view.snp.height)
            })
            
            view.clipsToBounds = true
            view.layer.cornerRadius = view.frame.width/2
            
            #warning("should add border \"ouside\" of view")
            // still looking for some way to achieve it.
            // maybe will try to add a CALayer below it.
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
            
            #warning("TODO: aplly image from commentersImage")
            if let imageView = view as? UIImageView {
                imageView.image = UIImage(named: "myKitty")
            }
        }
        
        commentButton.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
        }
        
        /// Note that commentIconButton is NOT an arranged view but a subview of footerStackview because of the stackview canvas constraint limit.
        cardFooterView.addSubview(commentIconButton)
        commentIconButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(-5)
            constraint.bottom.equalTo(4)
            constraint.right.equalTo(0)
            constraint.width.equalTo(commentIconButton.snp.height)
        }
        
        let footerSeparator = UIView()
        cardFooterView.addSubview(footerSeparator)
        footerSeparator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        footerSeparator.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.centerY.equalTo(self.snp.top).offset(-1)
            constraint.height.equalTo(1)
        }
        
        CardFooterViewLog("Finishing layoutSubviews")
    }
}

private struct CardFooterViewLog {
    @discardableResult
    init(_ message: String, sendToSlack: Bool = false) {
        CardViewLog(message, view: "CardFooterView")
    }
}

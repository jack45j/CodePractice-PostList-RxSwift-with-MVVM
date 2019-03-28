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
    
    /// UI elements
    ///
    lazy var cardHeaderView = CardHeaderView()
    lazy var cardBodyView = CardBodyView()
    lazy var cardFooterView = CardFooterView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCardView() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
    }
    
    override func layoutSubviews() {
        let innerView = UIStackView(arrangedSubviews: [cardHeaderView, cardBodyView, cardFooterView])
        innerView.axis = .vertical
        innerView.spacing = 0
        self.addSubview(innerView)
        
        innerView.snp.makeConstraints { (constraint) in
            constraint.top.left.equalTo(12)
            constraint.bottom.right.equalTo(-12)
        }
        
        /// add custom shadows to card view
        #warning("Will add shadow again once after device rotate")
        applyShadows()
    }
    
    func applyShadows() {
        
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
}

struct CardViewLog {
    @discardableResult
    init(_ message: String, view: String, sendToSlack: Bool = false) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if appDelegate.enableDebugLog {
                
                if sendToSlack {
                    let slackBot = Slackbot(
                        url: "https://hooks.slack.com/services/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")
                    slackBot.sendMessage(message: "[CardView (\(view))] \(message)")
                }
                NSLog("[CardView (\(view))] \(message)")
            }
        }
    }
}

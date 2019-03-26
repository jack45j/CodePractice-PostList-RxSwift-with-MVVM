//
//  CardFooterView.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/26.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit

class CardFooterView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCardFooterView()
    }
    
    func initCardFooterView() {
        
        CardFooterViewLog("Start init view")
        
        #warning("Do some configuration.")
    }
    
    override func layoutSubviews() {
        
        CardFooterViewLog("Start layoutSubviews")
        
        let cardFooterView = UIStackView()
        cardFooterView.axis = .horizontal
        self.addSubview(cardFooterView)
        
        CardFooterViewLog("Making cardFooterView constraints")
        cardFooterView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.left.equalTo(12)
            constraint.right.equalTo(-12)
            constraint.height.equalTo(44)
        }
        
        CardFooterViewLog("Making footerSeparator constraints")
        let footerSeparator = UIView()
        cardFooterView.addSubview(footerSeparator)
        footerSeparator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        footerSeparator.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.centerY.equalTo(cardFooterView.snp.top).offset(-1)
            constraint.height.equalTo(1)
        }
    }
}

private struct CardFooterViewLog {
    @discardableResult
    init(_ message: String) {
        CardViewLog(message, view: "CardFooterView")
    }
}

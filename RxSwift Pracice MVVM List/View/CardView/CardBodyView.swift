//
//  CardBodyView.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/26.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit

class CardBodyView: UIView {
    
    /// UI elements
    let postTitleContainerView = UIView()
    lazy var postTitleLabel = UILabel()
    
    let postBodyContainerView = UIView()
    lazy var postBodyLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardBodyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCardBodyView()
    }
    
    func initCardBodyView() {
        
        CardBodyViewLog("Start init view")
        
        postTitleLabel.numberOfLines = 1
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        postBodyLabel.attributedText = NSAttributedString(
            string: "\(String(describing: postBodyLabel.text))", attributes: attributes)
        postBodyLabel.numberOfLines = 0
        postBodyLabel.textAlignment = .justified
        postBodyLabel.font = UIFont.systemFont(ofSize: 13)
        postBodyLabel.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
    }
    
    override func layoutSubviews() {
        
        CardBodyViewLog("Start layoutSubviews")
        
        let cardBodyView = UIStackView(arrangedSubviews: [postTitleContainerView, postBodyContainerView])
        cardBodyView.axis = .vertical
        cardBodyView.spacing = 0
        self.addSubview(cardBodyView)
        
        CardBodyViewLog("Making cardBodyView constraints")
        cardBodyView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.equalTo(0)
            constraint.left.equalTo(12)
            constraint.right.equalTo(-12)
        }
        
        CardBodyViewLog("Making postTitleContainerView constraints")
        postTitleContainerView.addSubview(postTitleLabel)
        postTitleContainerView.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.height.equalTo(40)
        }
        
        CardBodyViewLog("Making postTitleLabel constraints")
        postTitleLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.left.right.equalTo(0)
        }
        
        CardBodyViewLog("Making postBodyContainerView constraints")
        postBodyContainerView.addSubview(postBodyLabel)
        postBodyContainerView.snp.makeConstraints { (constraint) in
            constraint.left.right.bottom.equalTo(0)
        }
        
        CardBodyViewLog("Making postBodyLabel constraints")
        postBodyLabel.snp.makeConstraints { (constraint) in
            constraint.top.left.right.equalTo(0)
            constraint.bottom.equalTo(-14)
        }
    }
}

private struct CardBodyViewLog {
    @discardableResult
    init(_ message: String) {
        CardViewLog(message, view: "CardBodyView")
    }
}

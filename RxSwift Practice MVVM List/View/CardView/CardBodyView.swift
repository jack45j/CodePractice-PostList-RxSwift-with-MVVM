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
    lazy var postTitleLabel = UILabel()
    lazy var postBodyLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCardBodyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCardBodyView() {
        
        CardBodyViewLog("Start init view")
        
        postTitleLabel.numberOfLines = 1
        postTitleLabel.font = UIFont.systemFont(ofSize: 17)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
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
        
        let cardBodyView = UIStackView(arrangedSubviews: [postTitleLabel, postBodyLabel])
        cardBodyView.axis = .vertical
        cardBodyView.spacing = 6
        self.addSubview(cardBodyView)
        
        cardBodyView.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.top.equalTo(13)
            constraint.bottom.equalTo(-12)
        }
        
        postTitleLabel.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
            constraint.height.equalTo(25)
        }
        
        postBodyLabel.snp.makeConstraints { (constraint) in
            constraint.left.right.equalTo(0)
        }
        
        CardBodyViewLog("Finishing layoutSubviews")
    }
}

private struct CardBodyViewLog {
    @discardableResult
    init(_ message: String) {
        CardViewLog(message, view: "CardBodyView")
    }
}

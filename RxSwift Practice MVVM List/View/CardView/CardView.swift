//
//  CardView.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/25.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CardView: UIView {
    
    /// UI elements
    ///
    lazy var cardHeaderView = CardHeaderView()
    lazy var cardBodyView = CardBodyView()
    lazy var cardFooterView = CardFooterView()
    
    var shadowLayers = [CALayer]()
    
    let disposeBag = DisposeBag()
    
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
        
        /// observe device orientation.
        NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification)
            .subscribe(
                onNext: { _ in
                    
                    self.shadowLayers.forEach { $0.removeFromSuperlayer() }
                    self.shadowLayers.removeAll()
                    self.resetShadows()
                })
            .disposed(by: disposeBag)
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
        
        resetShadows()
    }
    
    func resetShadows() {
        if shadowLayers.isEmpty {
            shadowLayers = makeShadows()
            shadowLayers.forEach { (layer) in
                self.layer.insertSublayer(layer, at: 0)
            }
        }
    }
    
    /// add custom shadows to card view
    func makeShadows() -> [CALayer] {
        
        CardViewLog("Start making shadows.")
        
        var layers = [CALayer]()
        
        let firstShadow = makeShadow(radius: 8,
                                     blur: 2,
                                     offset: CGSize(width: 0, height: 1),
                                     bgColor: UIColor.white.cgColor,
                                     shadowColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.18).cgColor)
    
        let secondShadow = makeShadow(radius: 8,
                                      blur: 0,
                                      offset: CGSize(width: 0, height: 1),
                                      bgColor: UIColor.white.cgColor,
                                      shadowColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor)

        let thirdShadow = makeShadow(radius: 8,
                                     blur: 6,
                                     offset: CGSize(width: 0, height: 2),
                                     bgColor: UIColor.white.cgColor,
                                     shadowColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor)
        
        layers.append(firstShadow)
        layers.append(secondShadow)
        layers.append(thirdShadow)

        return layers
    }
    
    func makeShadow(radius: CGFloat,
                    blur: CGFloat,
                    offset: CGSize,
                    bgColor: CGColor,
                    shadowColor: CGColor) -> CALayer {
        
        let shadow = CALayer()
        shadow.frame = self.bounds
        shadow.cornerRadius = radius
        shadow.shadowRadius = blur/2
        shadow.backgroundColor = bgColor
        shadow.shadowOffset = offset
        shadow.shadowColor = shadowColor
        shadow.shadowOpacity = 1
        
        return shadow
    }
}

struct CardViewLog {
    @discardableResult
    init(_ message: String, view: String = "self") {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if appDelegate.enableDebugLog {
                NSLog("[CardView (\(view))] \(message)")
            }
        }
    }
}

//
//  UIViewController+Rx.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/28.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}

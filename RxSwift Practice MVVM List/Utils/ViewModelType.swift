//
//  ViewModelType.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/28.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

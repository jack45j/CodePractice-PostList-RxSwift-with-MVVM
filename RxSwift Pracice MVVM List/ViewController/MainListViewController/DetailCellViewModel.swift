//
//  DetailCellViewModel.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/21.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import Foundation

struct DetailCellViewModel {
    let title: String
    let body: String
}

extension DetailCellViewModel {
    init(post: Post) {
        title = post.title!
        body = post.body!
    }
}

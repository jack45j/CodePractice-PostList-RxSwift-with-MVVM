//
//  CommentsViewModel.swift
//  RxSwift Practice MVVM List
//
//  Created by 林翌埕 on 2019/4/1.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import RxSwift
import RxCocoa

struct CommentViewModel {
    let postId: Int
    let body: String
}

extension CommentViewModel {
    init(comment: Comment) {
        self.postId = comment.postId
        self.body = comment.body
    }
}

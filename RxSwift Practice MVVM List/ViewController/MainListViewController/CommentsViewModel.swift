//
//  CommentsViewModel.swift
//  RxSwift Practice MVVM List
//
//  Created by 林翌埕 on 2019/4/1.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import RxSwift
import RxCocoa

class CommentsViewModel: ViewModelType {
    
    struct Input {
        let initial: Driver<Void>
    }
    
    struct Output {
        let comments: Driver<[CommentViewModel]>
    }
    
    struct Dependencies {
        let networkingApi: NetworkingApi
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: Input) -> Output {
        let initialComments = input.initial
            .flatMap { _ in
                self.dependencies.networkingApi
                    .commentsData()
                    .asSingle()
                    .asDriver(onErrorJustReturn: [])
        }
        
        let commentViewModels = initialComments.map{ $0.map { CommentViewModel(comment: $0) } }
        return Output(comments: commentViewModels)
    }
}

struct CommentViewModel {
    let postId: String
    let body: String
}

extension CommentViewModel {
    init(comment: Comment) {
        self.postId = comment.postId
        self.body = comment.body
    }
}

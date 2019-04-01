//
//  DetailCellViewModel.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/21.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import RxSwift
import RxCocoa

class PostsViewModel: ViewModelType {
    
    struct Input {
        let initial: Driver<Void>
    }
    
    struct Output {
        let posts: Driver<[PostViewModel]>
    }
    
    struct Dependencies {
        let networkingApi: NetworkingApi
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: Input) -> Output {
        let initialPosts = input.initial
            .flatMap { _ in
                self.dependencies.networkingApi
                    .postsData()
                    .asSingle()
                    .asDriver(onErrorJustReturn: [])
        }
        
        let postViewModels = initialPosts.map{ $0.map { PostViewModel(post: $0) } }
        
        return Output(posts: postViewModels)
    }
}

struct PostViewModel {
    let title: String
    let body: String
    let timestamp: String
}

extension PostViewModel {
    init(post: Post) {
        self.title = post.title
        self.body = post.body
        self.timestamp = timestampFormatter.string(
            from: Date(timeIntervalSince1970: generateRandomDate(daysBack: 100)))
    }
}


/// timestamp formatter
///
private var timestampFormatter: DateFormatter {
    let timeStampFormatter = DateFormatter()
    
    timeStampFormatter.dateFormat = "dd MMM yyyy"
    
    return timeStampFormatter
}

/// random a timestamp within the days back from today
///
private func generateRandomDate(daysBack: Int)-> TimeInterval {
    let day = arc4random_uniform(UInt32(daysBack))+1
    let hour = arc4random_uniform(23)
    let minute = arc4random_uniform(59)
    
    let today = Date(timeIntervalSinceNow: 0)
    let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    var offsetComponents = DateComponents()
    offsetComponents.day = Int(day - 1)
    offsetComponents.hour = Int(hour)
    offsetComponents.minute = Int(minute)
    
    let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0))
    return randomDate!.timeIntervalSince1970
}

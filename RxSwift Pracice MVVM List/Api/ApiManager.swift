//
//  ApiManager.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/13.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa
import RxAlamofire

class ApiManager {
    
    let session = URLSession.shared
    
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case posts = "/posts"
        
        private var baseURL: String { return "https://jsonplaceholder.typicode.com" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    
    var postsData: Observable<[Post]> = Observable.create { (observer) -> Disposable in
        let disposeBag = DisposeBag()
        
        RxAlamofire.requestJSON(URLRequest(url: Address.posts.url))
            .subscribe(
                onNext: { (response, json) in
                    guard
                        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []),
                        let postsData = try? JSONDecoder().decode([Post].self, from: jsonData)
                        else { return }
                    observer.onNext(postsData)
            })
        
        return Disposables.create()
    }
}

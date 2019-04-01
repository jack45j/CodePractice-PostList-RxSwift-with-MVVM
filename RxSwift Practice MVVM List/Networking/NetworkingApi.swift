//
//  ApiManager.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/13.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import RxSwift
import RxCocoa

protocol NetworkingService {
    func postsData() -> Observable<[Post]>
    func commentsData() -> Observable<[Post]>
}

class NetworkingApi {
    
    let session = URLSession.shared
    
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case posts = "/posts"
        case comments = "/comments"
        
        private var baseURL: String { return "https://jsonplaceholder.typicode.com" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
        
        func with(id: String) -> URL {
            switch self {
            case .posts:
                return URL(string: "\(self.url)?userId=\(id)")!
            case .comments:
                return URL(string: "\(self.url)?postId=\(id)")!
            }
        }
    }
    
    func postsData() -> Observable<[Post]> {
        let request = URLRequest(url: Address.posts.url)
        
        return URLSession.shared.rx.data(request: request)
            .map { data -> [Post] in
                guard let jsonResponse = try? JSONDecoder().decode([Post].self, from: data) else
                { return [] }
                return jsonResponse
        }
    }
    
    func commentsData(with postId: String? = String()) -> Observable<[Comment]> {
        var request = URLRequest(url: Address.comments.url)
        
        if postId == nil {
            request = URLRequest(url: Address.comments.url)
        } else {
            request = URLRequest(url: Address.comments.with(id: postId!))
        }
        
        return URLSession.shared.rx.data(request: request)
            .map { data -> [Comment] in
                guard let jsonResponse = try? JSONDecoder().decode([Comment].self, from: data) else
                { return [] }
                return jsonResponse
        }
    }
}

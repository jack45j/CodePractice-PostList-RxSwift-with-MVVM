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
}

class NetworkingApi {
    
    let session = URLSession.shared
    
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case posts = "/posts"
        
        private var baseURL: String { return "https://jsonplaceholder.typicode.com" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
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
}

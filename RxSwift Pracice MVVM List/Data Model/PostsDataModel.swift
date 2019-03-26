//
//  PostsDataModel.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/13.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        
        case userId
        case id
        case title
        case body
    }
    
    init(from decoder: Decoder) throws {
        let posts = try decoder.container(keyedBy: CodingKeys.self)
        userId = try posts.decodeIfPresent(Int.self, forKey: .userId)
        id = try posts.decodeIfPresent(Int.self, forKey: .id)
        title = try posts.decodeIfPresent(String.self, forKey: .title)
        body = try posts.decodeIfPresent(String.self, forKey: .body)
    }
}

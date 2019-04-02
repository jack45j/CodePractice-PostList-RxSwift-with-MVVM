//
//  Comment.swift
//  RxSwift Practice MVVM List
//
//  Created by 林翌埕 on 2019/3/29.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
    
    init(from decoder: Decoder) throws {
        let posts = try decoder.container(keyedBy: CodingKeys.self)
        postId = try posts.decodeIfPresent(Int.self, forKey: .postId)!
        id = try posts.decodeIfPresent(Int.self, forKey: .id)!
        name = try posts.decodeIfPresent(String.self, forKey: .name)!
        email = try posts.decodeIfPresent(String.self, forKey: .email)!
        body = try posts.decodeIfPresent(String.self, forKey: .body)!
    }
}

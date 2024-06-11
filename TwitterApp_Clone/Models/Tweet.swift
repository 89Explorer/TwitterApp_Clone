//
//  Tweet.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 6/12/24.
//

import Foundation


struct Tweet: Codable, Identifiable {
    var id = UUID().uuidString
    let author: TwitterUser
    let authorID: String
    let tweetContent: String
    var likesCount: Int
    var likers: [String]
    let isReply: Bool
    let parentReference: String?
}

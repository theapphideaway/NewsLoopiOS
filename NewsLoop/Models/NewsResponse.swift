//
//  NewsResponse.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/23/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit

struct NewsResponse: Codable {
    var articles = [ArticleContent]()
}

struct ArticleContent: Codable {
    var author: String?
    var content: String?
    var description: String?
    var publishedAt: String?
    var source = Source()
    var title: String
    var url: String
    var urlToImage: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}

struct Photos{
    var thumbnails = [UIImage]()
}

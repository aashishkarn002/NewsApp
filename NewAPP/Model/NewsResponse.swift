//
//  NewsResponse.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
       
    }
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
       case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

// MARK: - Source
struct Source: Codable {
    let id, name: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"

    }
}

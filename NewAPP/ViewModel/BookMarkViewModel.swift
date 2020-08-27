//
//  BookMarkViewModel.swift
//  NewsAPP
//
//  Created by Aashish on 8/28/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
struct BookMarkViewModel {
    
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let name: String?
    
    private let data: NewsArticle
    
    init(from rp: NewsArticle) {
        self.data = rp
        self.author = rp.article_author ?? ""
        self.title = rp.article_title
        self.articleDescription = (rp.article_description == "" || rp.article_description == nil) ? rp.article_content : rp.article_description
        self.url = rp.article_url ?? ""
        self.urlToImage = rp.article_image_url ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSFc_0xCXZmKFNoEY2bSPtX7jNKrGWXKbx-Bw&usqp=CAU"
        self.publishedAt = rp.article_published_at?.formatAPIDateTimeString("dd MMM,yyyy") ?? ""
        self.content = rp.article_content ?? ""
        self.name = rp.article_name
    }
    
    func getRP() -> NewsArticle {
        return data
    }
}

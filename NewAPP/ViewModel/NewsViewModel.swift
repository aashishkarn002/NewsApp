//
//  NewViewModel.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
struct NewsViewModel {
    
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source?
    
    private let data: Article
    
    init(from rp: Article) {
        self.data = rp
        self.author = rp.author ?? ""
        self.title = rp.title
        self.articleDescription = rp.articleDescription ?? "The description for this article not found. "
        self.url = rp.url ?? ""
        self.urlToImage = rp.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSFc_0xCXZmKFNoEY2bSPtX7jNKrGWXKbx-Bw&usqp=CAU"
        self.publishedAt = rp.publishedAt?.formatAPIDateTimeString("dd MMM,yyyy") ?? ""
        self.content = rp.content ?? ""
        self.source = rp.source
    }
    
    func getRP() -> Article {
        return data
    }
}

//
//  NewsDetailSourceAndDateCell.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit

class NewsDetailSourceAndDateCell: UITableViewCell {

    @IBOutlet weak var newsDetailTimeLabel: UILabel!
    @IBOutlet weak var newsDetailDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bind(article: Article) {
        self.newsDetailTimeLabel.text = Date().timeInterval(timeAgo: article.publishedAt ?? "")
        self.newsDetailDateLabel.text = article.publishedAt?.formatAPIDateTimeString("dd MMM,yyyy") ?? "N/A"
    }
    func bindWithNewsArticle(article: NewsArticle) {
        self.newsDetailTimeLabel.text = Date().timeInterval(timeAgo: article.article_published_at ?? "")
        self.newsDetailDateLabel.text = article.article_published_at?.formatAPIDateTimeString("dd MMM,yyyy") ?? "N/A"
    }
    
}

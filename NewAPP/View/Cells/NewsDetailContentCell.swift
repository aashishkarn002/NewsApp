//
//  NewsDetailContentCell.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit

class NewsDetailContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bind(article: Article) {
        self.contentLabel.text = article.content ?? ""
    }
    func bindWithNewsArticle(article: NewsArticle) {
        self.contentLabel.text = article.article_content ?? ""
    }
    
}

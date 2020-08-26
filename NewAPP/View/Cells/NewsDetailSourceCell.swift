//
//  NewsDetailSourceCell.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit

class NewsDetailSourceCell: UITableViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceShortLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func bind(article: Article) {
        self.sourceLabel.text = article.source?.name ?? "N/A"
        self.sourceShortLabel.text = article.source?.name?.first?.description ?? "N/A"
    }
    
}

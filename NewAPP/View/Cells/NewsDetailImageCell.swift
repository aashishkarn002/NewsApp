//
//  NewsDetailImageCell.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit

class NewsDetailImageCell: UITableViewCell {
    
    @IBOutlet weak var newsDetailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func bind(article: Article) {
        UIImage.download(from: article.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSFc_0xCXZmKFNoEY2bSPtX7jNKrGWXKbx-Bw&usqp=CAU") { (image) in
            DispatchQueue.main.async {
                self.newsDetailImageView?.image = image
            }
        }
        UIView.animate(withDuration: 0.08) {
            self.imageView?.alpha = 1.0
        }
    }
    
}

//
//  HeadlineCell.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headlineImageView.layer.masksToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //Rendering Data to Cell
    func bind(viewModel: NewsViewModel) {
        self.headlineTitleLabel.text = viewModel.title
        self.headlineContentLabel.text = viewModel.articleDescription
        
        UIImage.download(from: viewModel.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSFc_0xCXZmKFNoEY2bSPtX7jNKrGWXKbx-Bw&usqp=CAU") { (image) in
            DispatchQueue.main.async {
                self.headlineImageView?.image = image
            }
        }
        UIView.animate(withDuration: 0.08) {
            self.imageView?.alpha = 1.0
        }
    }
    
}

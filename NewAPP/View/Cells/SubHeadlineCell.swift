//
//  SubHeadlineCell.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit

class SubHeadlineCell: UITableViewCell {
    
    @IBOutlet weak var subheadlineDescriptionLabel: UILabel!
    @IBOutlet weak var subHeadlineLabel: UILabel!
    @IBOutlet weak var subHeadlineSourceLabel: UILabel!
    @IBOutlet weak var subHeadlineImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //Rendering Data to Cell
    func bind(viewModel: NewsViewModel) {
        self.subHeadlineSourceLabel.text = (viewModel.source?.name ??  "Not Identified")
        self.subheadlineDescriptionLabel.text = viewModel.articleDescription
        self.subHeadlineLabel.text = viewModel.title
        UIImage.download(from: viewModel.urlToImage ?? "") { (image) in
            DispatchQueue.main.async {
                self.subHeadlineImageView?.image = image
            }
        }
        UIView.animate(withDuration: 0.08) {
            self.imageView?.alpha = 1.0
        }
    }
    
}

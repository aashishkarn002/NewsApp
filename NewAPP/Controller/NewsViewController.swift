//
//  NewsViewController.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class NewsViewController: UIViewController {
    private let viewModel: NewsListViewModel
    private var article:[Article] = []
    init(viewModel:NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName:nil,bundle:nil)
        
    }
    required init?(coder:NSCoder) {
        self.viewModel = NewsListViewModel(apiClient:APIClient(url:""))
        super.init(coder:coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNew()
    }
}
extension NewsViewController {
    private func getNew(){
        self.viewModel.callNews { (result) in
            switch result {
            case .success(let article):
                self.article = article
                print(self.article)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  NewsViewController.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
class NewsViewController: UIViewController {
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //Initialinzing ActivityData for NVActivityIndicatorView to show loading view.
    let activityData = ActivityData(size: CGSize(width: 50.0, height: 50.0), message: "Loading....", messageFont: UIFont(name: "Montserrat", size: 18), messageSpacing: 10.0, type: .ballSpinFadeLoader, color: .appColor, padding: 10.0, displayTimeThreshold: 8, minimumDisplayTime: 5, backgroundColor: .clear, textColor: .appColor)
    private let networkManager: NetworkManager
    var newsCellDataSource: [NewsCellTypes]?
    
    //Initializing NewsViewModel
    private var newsListCellViewModel: [NewsViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //Initializing Network Manager
    init(networkManager:NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName:nil,bundle:nil)
        
    }
    required init?(coder:NSCoder) {
        self.networkManager = NetworkManager(apiClient:APIClient(url:""))
        super.init(coder:coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiSetup()
        self.registerTableViewCells()
        self.tableView.isHidden = true
        //Calling the News API
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        self.getNews {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            self.tableView.isHidden = false
        } 
    }
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        self.handleRefresh()
    }
}
//UISetup
extension NewsViewController {
    //Initial Setup Of UI
    func uiSetup(){
        self.title =  Titles.MainPageTitle.rawValue
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.dateLabel.text = Date().formattedCurrentDateTimeString()
        self.newsCellDataSource = [.HeadlineCell,.SubHeadlineCell]
        
    }
    //Registering Cell to Table View
    func registerTableViewCells() {
        tableView.register(UINib(nibName: Cells.HeadlineCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.HeadlineCellIdentifier.rawValue)
        tableView.register(UINib(nibName: Cells.SubHeadlineCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.SubHeadlineCellIdentifier.rawValue)
    }
}
//API CAll For News
extension NewsViewController {
    //Api Calling for News
    private func getNews(completion:@escaping () -> ()){
        self.networkManager.callNews { (result) in
            switch result {
            case .success(let article):
                DispatchQueue.main.async {
                    self.newsListCellViewModel = article.map({NewsViewModel(from: $0) })
                }
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
//Table View DataSource
extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsCellDataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newsSection = newsCellDataSource?[section].rawValue
        //For Header Section
        if newsSection == Cells.HeadlineCell.rawValue {
            return  1
        }
            //For SubHeader Section
        else if  newsSection == Cells.SubHeadlineCell.rawValue{
            return newsListCellViewModel.count - 1
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSourceUnwrapped = newsCellDataSource?[indexPath.section]
        //Cell for Header Section
        if dataSourceUnwrapped?.rawValue == Cells.HeadlineCell.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.HeadlineCellIdentifier.rawValue, for: indexPath) as? HeadlineCell else {
                return UITableViewCell()
            }
            if newsListCellViewModel.count != 0 {
                cell.bind(viewModel: newsListCellViewModel.first!)
            }
            
            return cell
        }
        //Cell for SubHeader Section
        if dataSourceUnwrapped?.rawValue == Cells.SubHeadlineCell.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.SubHeadlineCellIdentifier.rawValue, for: indexPath) as? SubHeadlineCell else {
                return UITableViewCell()
            }
            cell.bind(viewModel: newsListCellViewModel[indexPath.row+1])
            return cell
            
        }
        return UITableViewCell()
        
    }
    
}
//Table View Delegate
extension NewsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let delegateUnwrapped = newsCellDataSource?[indexPath.section]
        //Setting height For Header Section
        if delegateUnwrapped?.rawValue ==  Cells.HeadlineCell.rawValue{
            return UITableView.automaticDimension
        }
        //Setting height For SubHeader Section
        if delegateUnwrapped?.rawValue ==  Cells.SubHeadlineCell.rawValue{
            return 200
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

//Refresh Control
extension NewsViewController {
    //Calling News API Again when refresh naviagation bar button clicked.
    func handleRefresh() {
        self.newsListCellViewModel.removeAll()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        self.tableView.isHidden = true
        self.getNews {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            self.tableView.isHidden = false
        }
    }
}

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
    var coreDataStack: CoreDataStack!
    //Initialinzing ActivityData for NVActivityIndicatorView to show loading view.
    var nvActivityData:ActivityData!
    private let networkManager: NetworkManager
    private var newsCellDataSource: [NewsCellTypes]?
    
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
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.nvActivityData)
        self.getNews {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
        } 
    }
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        self.handleRefresh()
    }
}
//UISetup
extension NewsViewController {
    //Initial Setup Of UI
    private func uiSetup(){
        self.title =  Titles.MainPageTitle.rawValue
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.dateLabel.text = Date().formattedCurrentDateTimeString()
        self.newsCellDataSource = [.HeadlineCell,.SubHeadlineCell]
        
    }
    //Registering Cell to Table View
    private func registerTableViewCells() {
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
                    if article.count != 0 {
                        self.newsListCellViewModel = article.map({NewsViewModel(from: $0) })
                        self.tableView.isHidden = false
                    }
                    else {
                        self.showAlertMessage(titleStr: "Message", messageStr: "Sorry!! No article found")
                        self.tableView.isHidden = true
                    }
                }
                completion()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertMessage(titleStr: "Message", messageStr: error.description)
                    self.tableView.isHidden = true
                }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegateUnwrapped = newsCellDataSource?[indexPath.section]
        if delegateUnwrapped?.rawValue == Cells.HeadlineCell.rawValue {
            let mainStory = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
            let newsDetailVC = mainStory.instantiateViewController(withIdentifier:ViewControllerName.NewsDetailViewController.rawValue) as! NewsDetailViewController
            newsDetailVC.hidesBottomBarWhenPushed = true
            newsDetailVC.modalPresentationStyle = .fullScreen
            newsDetailVC.article = newsListCellViewModel.first?.getRP()
            newsDetailVC.coreDataStack = self.coreDataStack
            newsDetailVC.nvActivityData = self.nvActivityData
            self.navigationController?.pushViewController(newsDetailVC, animated: true)
            
        }
        if delegateUnwrapped?.rawValue == Cells.SubHeadlineCell.rawValue {
            let mainStory = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
            let newsDetailVC = mainStory.instantiateViewController(withIdentifier:ViewControllerName.NewsDetailViewController.rawValue) as! NewsDetailViewController
            newsDetailVC.hidesBottomBarWhenPushed = true
            newsDetailVC.modalPresentationStyle = .fullScreen
            newsDetailVC.article = newsListCellViewModel[indexPath.row + 1].getRP()
            newsDetailVC.coreDataStack = self.coreDataStack
            newsDetailVC.nvActivityData = self.nvActivityData
            self.navigationController?.pushViewController(newsDetailVC, animated: true)
        }
        
    }
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
    private func handleRefresh() {
        self.newsListCellViewModel.removeAll()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.nvActivityData)
        self.tableView.isHidden = true
        self.getNews {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            self.tableView.isHidden = false
        }
    }
}

//
//  NewsDetailViewController.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CoreData
class NewsDetailViewController: UIViewController {
    var article: Article?
    var newsArticle: NewsArticle?
    var newsCellDataSource: [NewsCellTypes]?
    var coreDataStack: CoreDataStack!
    var nvActivityData:ActivityData!
    var alreadySaved:Bool = false
    @IBOutlet weak var linkView: CircularBorderCard!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uISetup()
        self.registerTableViewCells()
        self.checkObjectAlreadySaved { (status) in
            switch status {
            case true:
                self.navigationItem.rightBarButtonItem?.tintColor = .yellow
                self.alreadySaved = true
            case false:
                self.navigationItem.rightBarButtonItem?.tintColor = .white
                self.alreadySaved = false
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
}
//UISetup
extension NewsDetailViewController {
    //Initial Setup For UI
    private  func uISetup(){
        self.title = Titles.DetailPageTitle.rawValue
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.newsCellDataSource = [.NewsDetailHeadlineCell,.NewsDetailSourceAndDateCell,.NewsDetailSourceCell,.NewsDetailImageCell,.NewsDetailDescriptionCell,.NewsDetailContentCell]
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        linkView.addGestureRecognizer(tap)
        let bookMark = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.handleNavigationRightButtonTap(_:)))
        self.navigationItem.rightBarButtonItem = bookMark
    }
    //Registering Cell to Table View
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: Cells.NewsDetailHeadlineCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.NewsDetailHeadlineCellIdentifier.rawValue)
        tableView.register(UINib(nibName: Cells.NewsDetailImageCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.NewsDetailImageCellIdentifier.rawValue)
        tableView.register(UINib(nibName: Cells.NewsDetailSourceAndDateCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.NewsDetailSourceAndDateCellIdentifier.rawValue)
        tableView.register(UINib(nibName: Cells.NewsDetailSourceCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.NewsDetailSourceCellIdentifier.rawValue)
        tableView.register(UINib(nibName: Cells.NewsDetailDescriptionCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.NewsDetailDescriptionCellIdentifier.rawValue)
        tableView.register(UINib(nibName: Cells.NewsDetailContentCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.NewsDetailContentCellIdentifier.rawValue)
        
    }
}
//TableView DataSource
extension NewsDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsCellDataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cell for Header Section
        let dataSourceUnwrapped = newsCellDataSource?[indexPath.section]
        switch dataSourceUnwrapped?.rawValue {
        case Cells.NewsDetailHeadlineCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsDetailHeadlineCellIdentifier.rawValue, for: indexPath) as? NewsDetailHeadlineCell else {
                return UITableViewCell()
            }
            self.article != nil ? cell.bind(article: self.article!) : cell.bindWithNewsArticle(article: newsArticle!)
            return cell
            
        case Cells.NewsDetailImageCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsDetailImageCellIdentifier.rawValue, for: indexPath) as? NewsDetailImageCell else {
                return UITableViewCell()
            }
            self.article != nil ? cell.bind(article: self.article!) : cell.bindWithNewsArticle(article: newsArticle!)
            return cell
        case Cells.NewsDetailSourceAndDateCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsDetailSourceAndDateCellIdentifier.rawValue, for: indexPath) as? NewsDetailSourceAndDateCell else {
                return UITableViewCell()
            }
           self.article != nil ? cell.bind(article: self.article!) : cell.bindWithNewsArticle(article: newsArticle!)
            return cell
        case Cells.NewsDetailSourceCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsDetailSourceCellIdentifier.rawValue, for: indexPath) as? NewsDetailSourceCell else {
                return UITableViewCell()
            }
            self.article != nil ? cell.bind(article: self.article!) : cell.bindWithNewsArticle(article: newsArticle!)
            return cell
        case Cells.NewsDetailDescriptionCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsDetailDescriptionCellIdentifier.rawValue, for: indexPath) as? NewsDetailDescriptionCell else {
                return UITableViewCell()
            }
            self.article != nil ? cell.bind(article: self.article!) : cell.bindWithNewsArticle(article: newsArticle!)
            return cell
            
        case Cells.NewsDetailContentCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsDetailContentCellIdentifier.rawValue, for: indexPath) as? NewsDetailContentCell else {
                return UITableViewCell()
            }
            self.article != nil ? cell.bind(article: self.article!) : cell.bindWithNewsArticle(article: newsArticle!)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
//TableView Delegate
extension NewsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let delegateUnwrapped = newsCellDataSource?[indexPath.section]
        if (delegateUnwrapped?.rawValue ==  Cells.NewsDetailImageCell.rawValue)
        {
            return 200
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
//Tap For Link View
extension NewsDetailViewController {
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let url = self.article != nil ? article?.url : newsArticle?.article_url else {
            return self.showAlertMessage(titleStr: "Message", messageStr: "No link found for the News.")
        }
        let mainStory = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
        let fullCoverageWebView = mainStory.instantiateViewController(withIdentifier:ViewControllerName.FullCoverageWebViewController.rawValue) as! FullCoverageWebViewController
        fullCoverageWebView.modalPresentationStyle = .fullScreen
        fullCoverageWebView.nvActivityData = self.nvActivityData
        fullCoverageWebView.url = url
        self.navigationController?.pushViewController(fullCoverageWebView, animated: true)
    }
}
extension NewsDetailViewController {
    // Tap function for navigation bar right button
    @objc func handleNavigationRightButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        if self.alreadySaved == false {
            self.article != nil ? self.coreDataStack.saveNews(article: self.article!) { (status) in
                switch status {
                case true:
                    self.showAlertMessage(titleStr: "Message", messageStr: "Bookmark Saved.")
                    self.navigationItem.rightBarButtonItem?.tintColor = .yellow
                    self.alreadySaved = true
                case false:
                    self.showAlertMessage(titleStr: "Message", messageStr: "There was error saving Bookmark.")
                }
                }  : self.coreDataStack.saveNewsArticle(newsArticle: self.newsArticle!) { (status) in
                switch status {
                case true:
                    self.showAlertMessage(titleStr: "Message", messageStr: "Bookmark Saved.")
                    self.navigationItem.rightBarButtonItem?.tintColor = .yellow
                    self.alreadySaved = true
                case false:
                    self.showAlertMessage(titleStr: "Message", messageStr: "There was error saving Bookmark.")
                }
            }
        }
        else if self.alreadySaved == true {
            self.coreDataStack.deleteObjectFromCoreData(sourceName: self.article != nil ? article?.source?.name ?? "" : self.newsArticle?.article_name ?? "", author: self.article != nil ? article?.author ?? "" : self.newsArticle?.article_author ?? "") { (status) in
                switch status {
                case true:
                    self.article != nil ? self.showAlertMessage(titleStr: "Message", messageStr: "Bookmark Successfully Deleted.") : self.showAlertWithOneAction(title: "Message", message: "Bookmark Successfully Deleted", handler: {
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.navigationItem.rightBarButtonItem?.tintColor = .white
                    self.alreadySaved = false
                case false:
                    self.showAlertMessage(titleStr: "Message", messageStr: "There was error deleting bookmark.")
                }
            }
        }
    }
    //Fetching if the object already saved in core data
    private func checkObjectAlreadySaved(completion: (_ complete: Bool) -> ()) {
        self.coreDataStack.checkObjectAlreadySaved(sourceName: self.article != nil ? article?.source?.name ?? "" : self.newsArticle?.article_name ?? "", author: self.article != nil ? article?.author ?? "" : self.newsArticle?.article_author ?? "") { (status) in
            switch status {
            case true:
                completion(true)
            case false:
                completion(false)
            }
        }
    }

}


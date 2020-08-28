//
//  BookMarkViewController.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//
import CoreData
import UIKit
import NVActivityIndicatorView
class BookMarkViewController: UIViewController {
    var coreDataStack: CoreDataStack!
    private var newsCellDataSource: [NewsCellTypes]?
    var nvActivityData:ActivityData!
    @IBOutlet weak var tableView: UITableView!
    private var bookMarkListCellViewModel: [BookMarkViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uISetup()
        self.registerTableViewCells()
        //Calling the NewsArticle Model
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.nvActivityData)
        
        self.getNewsArticle { (status) in
            switch status {
            case true:
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                self.setupForDeleteButton()
            case false:
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
}
//UISetup
extension BookMarkViewController {
    
    private func uISetup() {
        self.title = "BookMarks"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.newsCellDataSource = [.SubHeadlineCell]
        
    }
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: Cells.SubHeadlineCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.SubHeadlineCellIdentifier.rawValue)
    }
    private func setupForDeleteButton() {
        let bookMark = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.handleNavigationRightButtonTap(_:)))
        self.navigationItem.rightBarButtonItem = bookMark
    }
}
//Check CoreData Model Contain any Value
extension BookMarkViewController {
    private func getNewsArticle(completion:(_ complete: Bool) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataName.NewsArticleEntity.rawValue)
        if let articleResult = try? coreDataStack.managedObjectContext.fetch(fetchRequest) as? [NewsArticle] {
            if articleResult.count == 0 {
                self.tabBarController?.showAlertControllerMessage(titleStr: "Message", messageStr: "No Bookmarks Saved yet!!")
                completion(false)
            }
            else {
                self.bookMarkListCellViewModel =
                    articleResult.map({BookMarkViewModel(from: $0) })
                completion(true)
            }
        }
    }
}
//TableView DataSource
extension BookMarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.SubHeadlineCellIdentifier.rawValue, for: indexPath) as? SubHeadlineCell else {
            return UITableViewCell()
        }
        cell.bindWithBookMark(viewModel: bookMarkListCellViewModel[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookMarkListCellViewModel.count
    }
    
    
}
//TableView Delegate
extension BookMarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStory = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
        let newsDetailVC = mainStory.instantiateViewController(withIdentifier:ViewControllerName.NewsDetailViewController.rawValue) as! NewsDetailViewController
        newsDetailVC.hidesBottomBarWhenPushed = true
        newsDetailVC.modalPresentationStyle = .fullScreen
        newsDetailVC.newsArticle = bookMarkListCellViewModel[indexPath.row].getRP()
        newsDetailVC.coreDataStack = self.coreDataStack
        newsDetailVC.nvActivityData = self.nvActivityData
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.coreDataStack.deleteObjectFromCoreData(sourceName: self.bookMarkListCellViewModel[indexPath.row].name ?? "", author: self.bookMarkListCellViewModel[indexPath.row].author ?? "") { (status) in
                switch status {
                case true:
                    bookMarkListCellViewModel.remove(at: indexPath.row)
                    if self.bookMarkListCellViewModel.count == 0 {
                        self.navigationItem.rightBarButtonItem = nil
                    }
                case false:
                    self.tabBarController?.showAlertControllerMessage(titleStr: "Message", messageStr: "There was error deleting saved bookmarks.")
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
//Tap Gesture For Navigation Right Button Item
extension BookMarkViewController {
    @objc func handleNavigationRightButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        self.showAlertWithAction(title: "Message", message: "Are you sure you want to delete all saved bookmarks?") {
            self.coreDataStack.deleteAllFromCoreData { (status) in
                switch status {
                case true:
                    self.showAlertWithOneAction(title: "Message", message: "All Saved Bookmark Deleted Successfully.") {
                        self.bookMarkListCellViewModel.removeAll()
                        self.navigationItem.rightBarButtonItem = nil
                        self.tableView.reloadData()
                    }
                case false:
                    self.tabBarController?.showAlertControllerMessage(titleStr: "Message", messageStr: "There was error deleting all saved bookmarks.")
                }
            }
        }
        
    }
}

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
        self.getNewsArticle {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
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
}
//Check CoreData Model Contain any Value
extension BookMarkViewController {
    private func getNewsArticle(completion:@escaping () -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataName.NewsArticleEntity.rawValue)
        if let articleResult = try? coreDataStack.managedObjectContext.fetch(fetchRequest) as? [NewsArticle] {
            if articleResult.count == 0 {
                self.tabBarController?.showAlertControllerMessage(titleStr: "Message", messageStr: "No Bookmarks Saved yet!!")
                completion()
            }
            else {
                self.bookMarkListCellViewModel =
                    articleResult.map({BookMarkViewModel(from: $0) })
                completion()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

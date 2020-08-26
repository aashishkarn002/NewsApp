//
//  AppConstants.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
enum Cells:String {
    case HeadlineCell = "HeadlineCell"
    case HeadlineCellIdentifier = "headlineCell"
    case SubHeadlineCell = "SubHeadlineCell"
    case SubHeadlineCellIdentifier = "subHeadlineCell"
    case NewsDetailHeadlineCell = "NewsDetailHeadlineCell"
    case NewsDetailHeadlineCellIdentifier = "newsDetailHeadlineCell"
    case NewsDetailSourceCell = "NewsDetailSourceCell"
    case NewsDetailSourceCellIdentifier = "newsDetailSourceCell"
    case NewsDetailSourceAndDateCell = "NewsDetailSourceAndDateCell"
    case NewsDetailSourceAndDateCellIdentifier = "newsDetailSourceAndDateCell"
    case NewsDetailImageCell = "NewsDetailImageCell"
    case NewsDetailImageCellIdentifier = "newsDetailImageCell"
    case NewsDetailDescriptionCell = "NewsDetailDescriptionCell"
    case NewsDetailDescriptionCellIdentifier = "newsDetailDescriptionCell"
    case NewsDetailContentCell = "NewsDetailContentCell"
    case NewsDetailContentCellIdentifier = "newsDetailContentCell"
}
enum Titles:String {
    case MainPageTitle = "US News"
    case DetailPageTitle = "Detail"
    case FullCoverageWebViewControllerTitle = "Full Coverage"
}
enum Segue: String {
    case NewsDetailVC = "toNewsDetailVC"
}
enum StoryBoardName: String {
    case Main = "Main"
}
enum ViewControllerName: String {
    case NewsViewController = "NewsViewController"
    case NewsDetailViewController = "NewsDetailViewController"
    case FullCoverageWebViewController = "FullCoverageWebViewController"
}

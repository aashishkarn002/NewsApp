//
//  NewViewModel.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
class NewsListViewModel
{
    private var apiClient:APIClient!
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
   
}
extension NewsListViewModel {
     func callNews(completion: @escaping ResultCallback<[Article]>) {
           self.apiClient.send(path: WebService.newsURL) { (result) in
               switch result {
               case .success(let data):
               
                   guard let response = try? data.decode(to: NewsResponse.self) else {
                       completion(.failure(APIError.decoding))
                       return
                   }
                completion(.success(response.articles ?? []))
                   
               case .failure(let error):
                   completion(.failure(error))
                   
               }
           }
       }
}

//
//  NewsAPIResponse.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
struct NewsAPIResponse: Codable {
    let status, code, message: String
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case code = "code"
        case message = "message"
       
    }
}

//
//  Webservice.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
public class WebService {
    public static var shared: WebService {
        return singleton
    }
    private static let singleton: WebService = WebService()
    
    static var isLive: Bool = false
    
    
    public static var newsURL: String {
        return isLive ? "http://newsapi.org/v2/top-headlines?country=us&apiKey=0009d4fdcb0e47598cb7f0714d4b778e" : "http://newsapi.org/v2/top-headlines?country=us&apiKey=0009d4fdcb0e47598cb7f0714d4b778e"
    }
}

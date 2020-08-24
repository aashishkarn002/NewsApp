//
//  APIError.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import Foundation

public protocol AError: Error {
    var description: String { get }
}

extension AError {
    var description: String { return "" }
}

public enum APIError: AError {
    case encoding
    case decoding
    case server
    case unreachable
    case unknown
    case sessionTimeOut
    case formFieldError(Decodable)
    case error(_ error: Error)
    case message(_ message: String)
   
    case `default`
    
    public var description: String {
        switch self {
        case .encoding:
            return "Error encoding the parameters"
        case .decoding:
            return "Error decoding the paramenters"
        case .server:
            return "Server Error!!"
        case .sessionTimeOut:
            return "Connection Timeout. Slow internet Connection!"
        case .unreachable:
            return "No internet connection!!"
        case .unknown:
            return "Something went wrong!!"
        case .error(let error):
            return error.localizedDescription
        case .message(let message):
            return message
      
        default:
            return "Something went wrong!!"
        }
    }
}

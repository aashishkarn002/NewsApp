//
//  APIClient.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import Alamofire
public typealias PEncoding = ParameterEncoding
public typealias URLEncode = URLEncoding
public class APIClient: NSObject {
    private var baseUrl = ""
    fileprivate let sessionManager:  Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 40
        return Session(configuration: configuration)
    }()
    private var dataRequest: DataRequest?
    
    public init(url: String) {
        super.init()
        self.baseUrl = url
    }
    
    public func send(parameters: [String: Any]? = nil, path: String, accessToken: String? = nil, completion: @escaping ResultCallback<Data>) {
        guard Luminous.System.Network.isInternetAvailable else {
            completion(.failure(APIError.unreachable))
            return
        }
        guard let dataRequest = try? generateEndpoint(parameters: parameters, path: path, accessToken: accessToken) else {
            completion(.failure(APIError.unknown))
            return
        }
        self.dataRequest = dataRequest
        self.dataRequest?.responseData { (dataResponse) in
            
            if let error = dataResponse.error {
                completion(.failure(APIError.message(error.localizedDescription)))
                return
            }
            if let data = dataResponse.data {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    guard let status = json?["status"] as? String else  {
                        return completion(.failure(APIError.message("No status found for given end point.")))
                    }
                    if status.lowercased() == "ok" {
                        completion(.success(data))
                    }
                    else {
                        completion(.failure(APIError.message(json?["message"] as? String  ?? "Something went wrong!! Please try again")))
                    }
                }
                catch {
                    return completion(.failure(APIError.message(APIError.decoding.description)))
                }
            }
        }
    }
    
    public func cancel() {
        self.dataRequest?.cancel()
    }
    
    private func generateEndpoint(parameters: [String: Any]?, path: String, encoding: ParameterEncoding = JSONEncoding.default, accessToken: String? = nil) throws -> DataRequest {
        let absolutePath = "\(path)"
        guard let url = URL(string: absolutePath) else {
            throw APIError.message("The URL is not reachable!!")
        }
        
        let params = parameters ?? nil
        let headers : HTTPHeaders = [
            "Authorization": accessToken ?? "",
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
        
        let dataRequest = sessionManager.request(url, method: .get, parameters: params, encoding: encoding, headers: headers)
        
        return dataRequest
    }
}

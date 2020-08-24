//
//  Encodabale+Extensions.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
public extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let parametersData = try JSONEncoder().encode(self)
        let parameters = try JSONSerialization.jsonObject(with: parametersData, options: []) as? [String: Any]
        
        return parameters ?? [:]
    }
}

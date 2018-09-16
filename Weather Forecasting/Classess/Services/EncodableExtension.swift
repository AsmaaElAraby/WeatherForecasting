//
//  Encodable.swift
//  Weather Forecasting
//
//  Created by Asma on 9/14/18.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation

extension Encodable {
    
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var description: String {
        
        var asString = ""
        for element in dictionary {
            
            if asString != "" {
                asString += "&"
            }
            asString += "\(element.key)=\(element.value)"
        }
        
        return asString
    }

    static func decode<T: Decodable>(json: String, asA thing: T.Type) -> T? {
        let data = Data(json.utf8)
        do {
            return try JSONDecoder().decode(thing.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

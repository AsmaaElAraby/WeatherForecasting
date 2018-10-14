//
//  Encodable.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

extension Encodable {
    
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
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

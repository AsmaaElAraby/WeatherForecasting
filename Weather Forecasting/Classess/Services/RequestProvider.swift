//
//  URLsRouter.swift
//  Weather Forecasting
//
//  Created by Asmaa Mostafa on 25/09/2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import Alamofire

enum URLs: String {
    
    private static let base = "http://api.openweathermap.org/"
    case dailyForecast    = "forecast"
    case todayForecast    = "weather"
    
    var path: String {
        switch self {
        case .dailyForecast, .todayForecast:
            return "\(URLs.base)data/2.5/\(self.rawValue)?"
        }
    }
    
}

enum RequestProvider: URLRequestConvertible {

    case get(url: String, params: [String: Any]?)
    case post(url: String, params: [String: Any])

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            case .post:
                return .post
            }
        }

        let params: ([String: Any]?) = {
            switch self {
            case .get:
                return nil
            case .post(_, let newTodo):
                return (newTodo)
            }
        }()

        let path: String = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .get(let path, let params):
                guard let params = params else {
                    return path
                }
                relativePath = path.appending(urlHeaderStringFrom(dic: params))
            case .post(let path, _):
                relativePath = path
            }

            return relativePath ?? ""
        }()

        let url: URL = {
            guard let url = URL(string: path), path != "" else {
                fatalError("please check your url path again")
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)

    }
    
    private func urlHeaderStringFrom(dic: [String: Any]) -> String {
        
        return (dic.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
    }
    
}

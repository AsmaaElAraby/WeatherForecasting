//
//  APIManager.swift
//  MakersFair
//
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestDelegate: class {
    func willLoad()
    func didLoad<T: Codable>(data: T)
    func didFailWith(message: String)
}

class APIManager {
    
    static let shared = APIManager()
    
    /// Load data from url with GET method
    ///
    /// - Parameters:
    ///   - request     : RequestProvider
    ///   - onSuccess   : Block
    ///   - onFaliure   : Block
    internal func fetchDataFor(request: RequestProvider, onSuccess: @escaping (_ response : String?) -> Void, onFaliure: @escaping (_ error : Error) -> Void) {
        
        guard let urlRequest = request.urlRequest else {
            onFaliure(NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil) as Error)
            return
        }

        if Connectivity.isConnectedToInternet() {
            Alamofire.request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseString { response in
                
                self.manage(response: response, onSuccess: onSuccess, onFaliure: onFaliure)
            }
        } else {
            onFaliure(NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil) as Error)
        }
    }
    
    /// make sure that the success block only returns the success state and the faliure block returns the faliure state
    ///
    /// - Parameters:
    ///   - response    :  DataResponse<String>
    ///   - onSuccess   : Block
    ///   - onFaliure   : Block
    private func manage(response: DataResponse<String>, onSuccess: @escaping (_ response:  String?) -> Void, onFaliure: @escaping (_ error: Error) -> Void) {
        
        switch response.result {
        case .success:
            if response.result.error == nil && response.result.value != nil {
                
                onSuccess(response.result.value)
                
            } else {
                
                onFaliure(response.result.error!)
            }
            
        case .failure(let error):
            
            onFaliure(error)
        }
    }
    
}

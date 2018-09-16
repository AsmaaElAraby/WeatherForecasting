//
//  APIManager.swift
//  MakersFair
//
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    
    /// Load data from url with GET method
    ///
    /// - Parameters:
    ///   - url         : String (request url + user data)
    ///   - onSuccess   : Block
    ///   - onFaliure   : Block
    internal func requestDataWithGetMethod(url          :   String,
                                           onSuccess    :   @escaping (_ response : String?) -> Void,
                                           onFaliure    :   @escaping (_ error : Error) -> Void) {
        
        if Connectivity.isConnectedToInternet() {
            Alamofire.request(url).responseString { response in
                
                self.manageResponse(response: response, onSuccess: onSuccess, onFaliure: onFaliure)
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
    private func manageResponse(response    :   DataResponse<String>,
                                onSuccess   :   @escaping (_ response :  String?)    ->  Void,
                                onFaliure   :   @escaping (_ error : Error) -> Void) {
        
        switch response.result {
            
        case .success:
            if response.result.error == nil && response.result.value != nil {
                
                onSuccess(response.result.value)
                
            } else {
                
                onFaliure(response.result.error!)
            }
            break
            
        case .failure(let error):
            
            onFaliure(error)
            
            break
            
        }
    }
    
}

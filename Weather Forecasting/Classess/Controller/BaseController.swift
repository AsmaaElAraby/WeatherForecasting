//
//  BaseController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftMessages

class BaseController: NSObject {

    var viewController : UIViewController!
    
    
    /// display a success message view
    ///
    /// - Parameter message: String
    internal func showSuccessMessageAlert(message : String) {
        
        DispatchQueue.main.async {
            
            let indicator = AndicatingView()
            indicator.displayMessage(message: LocalizationManager().localizeStringWith(key: message), title: "Success", messageError: false)
        }
    }
    
    
    /// display an error message view
    ///
    /// - Parameter message: String
    internal func showErrorMessageAlert(message : String) {
        
        DispatchQueue.main.async {
            
            let indicator = AndicatingView()
            indicator.displayMessage(message: LocalizationManager().localizeStringWith(key: message), title: "Error", messageError: true)
        }
    }
}

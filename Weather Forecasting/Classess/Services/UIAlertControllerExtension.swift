//
//  UIAlertExtension.swift
//  Weather Forecasting
//
//  Created by Asmaa Mostafa on 02/10/2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// display alert to open the settings to ask the user to open it is location
    ///
    /// - Parameters:
    ///   - title: String
    ///   - message: String
    func settingsAlertWith(title: String, message: String, cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: cancelHandler)
            let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { _ in
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
}

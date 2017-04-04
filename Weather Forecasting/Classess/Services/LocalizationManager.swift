//
//  LocalizationManager.swift
//  MakersFair
//
//  Created by mac on 3/4/17.
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//


import UIKit

class LocalizationManager: NSObject {
    
    var StringsData: NSDictionary? = nil
    
    static let shared : LocalizationManager = LocalizationManager()
    
    func localizationList () {
        
        if StringsData == nil {
            
            if let path = Bundle.main.path(forResource: "Localization", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path)  {
                
                // use swift dictionary as normal
                StringsData = NSDictionary(dictionary: dict)
            }
        }
    }
    
    
    /// get the localized data for received key
    ///
    /// - parameter key: - string key in plist file -
    ///
    /// - returns: localized string for the recieved key
    func localizeStringWith (key: String) -> String {
        
        self.localizationList()

        var localizedMessage = ""
        if key.contains("\n") == true {
            
            let errors = key.components(separatedBy: "\n")
            
            if errors.count > 0 {
                
                for element in errors {
                    
                    localizedMessage += self.valueForKey(key: element)
                    
                    if element != errors.last {
                        localizedMessage += "\n"
                    }
                }
            }
        }
            
        else {
            localizedMessage = self.valueForKey(key: key)
        }
        
        return localizedMessage
    }
    
    private func valueForKey (key: String) -> String {
        
        if let data = self.StringsData {
            
            if data.count > 0  {
                
                let titleWithLanguages: NSDictionary? = data.value(forKey: key) as? NSDictionary
                
                if let title = titleWithLanguages {

                    if let text = title.value(forKey: "en") as? String {
                        
                        return text
                    }
                    
                    else {
                        
                        return key
                    }
                } else {
                    
                    return key
                }
            }
        }
        return ""
    }
    
}

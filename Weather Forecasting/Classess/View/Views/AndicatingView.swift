//
//  AndicatingView.swift
//  MakersFair
//
//  Created by mac on 3/11/17.
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//

import UIKit
import JGProgressHUD
import SwiftMessages

class AndicatingView: NSObject {

    private var currentView: UIView!
    private var activityIndicatorView: JGProgressHUD!
    
    
    /// start the indicator animation
    ///
    /// - Parameter view: UIView
    func startAnimating(view: UIView) {
        self.currentView = view
        self.activityIndicatorView = JGProgressHUD(style: JGProgressHUDStyle.light)
        self.activityIndicatorView?.show(in: currentView, animated: true)
    }

    
    /// stop animating the indicator and hide it
    func stopAnimating() {
        
        self.activityIndicatorView?.dismiss()
    }
    
    
    /// display message to the user
    ///
    /// - Parameters:
    ///   - message:    String
    ///   - title:      String
    ///   - messageError:   Bool (Is it an error message or not?)
    func displayMessage(message: String, title: String, messageError: Bool) {
        
        let view = MessageView.viewFromNib(layout: MessageView.Layout.centeredView)
        
        if messageError == true {
            view.configureTheme(.error)
        } else {
            view.configureTheme(.success)
        }
        
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
        view.bodyLabel?.text = message
        view.titleLabel?.text = title
        view.titleLabel?.textColor = UIColor.white
        view.bodyLabel?.textColor = UIColor.white
        view.configureDropShadow()

        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.dimMode = .gray(interactive: true)

        SwiftMessages.show(config: config, view: view)
    }

}

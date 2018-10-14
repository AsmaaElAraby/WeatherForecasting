//
//  AndicatingView.swift
//  MakersFair
//
//  Created by mac on 3/11/17.
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//

import UIKit
import JGProgressHUD

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
    
}

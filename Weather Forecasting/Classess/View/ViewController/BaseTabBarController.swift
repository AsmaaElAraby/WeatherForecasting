//
//  BaseTabBarController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import RevealingSplashView

class BaseTabBarController: UITabBarController {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setAnimatedLogoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTabBarApperance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// change the appearance of the tab bar items
    private func updateTabBarApperance() {
        
        // update the tab bar items selected and unselected images
        if let firstItem = self.tabBar.items?[0] {
            
            let image = UIImage(named:"Today")?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage(named:"SelectedSun")?.withRenderingMode(.alwaysOriginal)
            firstItem.image = image
            firstItem.selectedImage = selectedImage
        }
        
        if let secondItem = self.tabBar.items?[1] {
            
            let image = UIImage(named:"UnselectedForecast")?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage(named:"Forecast")?.withRenderingMode(.alwaysOriginal)
            secondItem.image = image
            secondItem.selectedImage = selectedImage
        }
        
        
        // update the tab bar text color
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: ApplicationColors.UnselectedTabbarItemColor], for:.normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: ApplicationColors.SelectedTabbarItemColor], for:.selected)

    }
    
    
    
    /// animate the splash screen to show the tabbar view screens
    private func setAnimatedLogoView() {
        
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Sun_Big")!,iconInitialSize: CGSize(width: 87, height: 87), backgroundColor: UIColor.white)
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.animationType = SplashAnimationType.swingAndZoomOut
        revealingSplashView.minimumBeats = 5
        revealingSplashView.heartAttack = true
        revealingSplashView.duration = 3
        revealingSplashView.delay = 0
        
        //Starts animation
        revealingSplashView.startAnimation()
    }
    
}


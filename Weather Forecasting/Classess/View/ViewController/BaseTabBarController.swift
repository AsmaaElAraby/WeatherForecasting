//
//  BaseTabBarController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setAnimatedLogoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTabBarApperance()
    }
    
    /// change the appearance of the tab bar items
    private func updateTabBarApperance() {
        
        // update the tab bar items selected and unselected images
        if let firstItem = tabBar.items?[0] {
            
            let image = UIImage(named: "Today")?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage(named: "SelectedSun")?.withRenderingMode(.alwaysOriginal)
            firstItem.image = image
            firstItem.selectedImage = selectedImage
        }
        
        if let secondItem = tabBar.items?[1] {
            
            let image = UIImage(named: "UnselectedForecast")?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage(named: "Forecast")?.withRenderingMode(.alwaysOriginal)
            secondItem.image = image
            secondItem.selectedImage = selectedImage
        }
        
        // update the tab bar text color
        UITabBarItem.appearance().setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedStringKey: ApplicationColors.tabBarItemUnselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedStringKey: ApplicationColors.tabBarItemSelectedColor], for: .selected)
    }
    
    
    
    // MARK: - Animation
    
    private func setAnimatedLogoView() {
        
        if let splashImage = UIImage(named: logoImageName) {
        
            let imageDimension: CGFloat = 87
            let splashImageView = UIImageView(image: splashImage)
            splashImageView.frame = CGRect(x: (UIScreen.main.bounds.size.width/2) - (imageDimension/2), y: (UIScreen.main.bounds.size.height/2) - (imageDimension/2), width: imageDimension, height: imageDimension)
            
            let splashView = UIView(frame: view.frame)
            splashView.backgroundColor = UIColor.white
            splashView.addSubview(splashImageView)
            
            //Adds the splash view as a sub view (temperary till applying animation)
            view.addSubview(splashView)
            
            let rotationDuration = 1.5
            rotate(targetView: splashImageView, duration: rotationDuration)
            scaleTillFadeout(targetView: splashView, duration: 2.75, delay: rotationDuration + 0.5)
        }
    }
    
    
    private var stopRotationAnimation = false
    private func rotate(targetView: UIView, duration: Double = 1.0, count: Int = 0) {
        
        guard stopRotationAnimation == false else {
            return
        }
        
        UIView.animate(withDuration: duration/3, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: 200)
        }) { _ in

            UIView.animate(withDuration: duration/3, delay: 0.0, options: .curveLinear, animations: {

                targetView.transform = targetView.transform.rotated(by: -200)

            }, completion: { [weak self] _ in

                if count == 1 {
                    self?.stopRotationAnimation = true
                }
                self?.rotate(targetView: targetView, duration: duration, count: count+1)
            })
        }
    }
    
    private func scaleTillFadeout(targetView: UIView, duration: Double = 1.0, delay: Double = 1.5) {

        UIView.animate(withDuration: duration, delay: delay, animations: {
            targetView.transform = CGAffineTransform(scaleX: 6, y: 6)
            targetView.alpha = 0
        }) { _ in
            targetView.removeFromSuperview()
        }
    }
    
}

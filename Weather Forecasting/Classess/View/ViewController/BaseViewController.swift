//
//  UIViewController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Animate table view cells
    
    @IBOutlet weak var noDataFoundLabel: UILabel?


    internal func animateTable(tableView : UITableView, animateDuration : Double) {
        tableView.reloadData()
        
        var animationDuration = 0.0
        if animateDuration >= 0.0 {
            animationDuration = 1.5
        }
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for cell in cells {
            UIView.animate(withDuration: animationDuration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            index += 1
        }
    }
    
}

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFromStoryboard (storyboard: StoryBoardes) -> Self {
        
        return storyboard.viewController(viewControllerClass: self)
    }
    
}

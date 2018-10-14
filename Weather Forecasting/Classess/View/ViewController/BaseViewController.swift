//
//  UIViewController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK : Animate table view cells
    
    @IBOutlet weak var noDataFoundLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataFoundLabel?.isHidden = true
    }
    
    internal func animateTable(tableView : UITableView, animateDuration : Double) {
        tableView.reloadData()
        
        var _animationDuration = 0.0
        if animateDuration >= 0.0 {
            _animationDuration = 1.5
        }
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: _animationDuration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            
            index += 1
        }
    }
    
}



extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromStoryboard (storyboard: StoryBoardes) -> Self {
        
        return storyboard.viewController(viewControllerClass: self)
    }
}

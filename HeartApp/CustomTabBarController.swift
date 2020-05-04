//
//  CustomTabBarController.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 4/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
       
        var frame = self.tabBar.frame
        frame.origin.y = 0
        
        self.tabBar.frame = frame

    }
    
    func getHeight() -> CGFloat {
        return self.tabBar.frame.height
    }

}

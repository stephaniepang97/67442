//
//  CustomTabBarController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/30/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class QuestionTabBarController: UINavigationController {

  @IBOutlet var customTabBarView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    customTabBarView.frame.size.width = self.view.frame.width
    customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
    customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
    self.view.addSubview(customTabBarView)
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

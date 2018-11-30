//
//  EndQuizViewController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/30/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import SwiftyJSON

class EndQuizViewController: UIViewController {
	var startTime : Date?
	var endTime : Date?
	var answeredQuestions : [JSON]?
	
	var sessionObject: SessionViewModel = SessionViewModel()
	
	
  @IBOutlet var customTabBarView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    customTabBarView.frame.size.width = self.view.frame.width
    customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
    customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
    self.view.addSubview(customTabBarView)
  }
}

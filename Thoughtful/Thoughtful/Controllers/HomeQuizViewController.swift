//
//  HomeQuizViewController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/27/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class HomeQuizViewController: UIViewController {
	
	@IBOutlet weak var greetingName : UILabel!
	
	@IBOutlet weak var loadingBackdrop : UIView!
	@IBOutlet weak var loadingCloud1 : UIImageView!
	@IBOutlet weak var loadingCloud2 : UIImageView!
	@IBOutlet weak var loadingCloud3 : UIImageView!
  
    @IBOutlet var customTabBarView: UIView!
  
	let loadingObject = LoadingScreen()
	var loaded = false
	var secondsElapsed = 0
	var timer = Timer()

	var userName : String = ""
	
	var familyName : String = ""

	var quizObject: QuizViewModel?
	
	var userObject: UserViewModel?
	
	var sessionObject: SessionViewModel?
	
	var currentUser : JSON = JSON()
	
	
	func configureView() -> Void {
		// Update the user interface for the detail item.
		self.greetingName.text = "hi, " + self.userName
		if let user: UserViewModel = self.userObject {
			var currentUser = user.currentUser
			self.currentUser = currentUser
			print(self.currentUser)
			print(self.currentUser["proper_name"].string!)
			print(self.greetingName.text)
			self.loaded = true
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// start loading screen
		startLoadingScreen()
		// Do any additional setup after loading the view, typically from a nib.
		userObject?.currentUserFamilyName = self.familyName
		userObject?.currentUserName = self.userName
		// Do any additional setup after loading the view, typically from a nib.
		userObject?.refresh { [unowned self] in
			DispatchQueue.main.async {
				self.userObject!.fetchUser(familyName: self.familyName, userName: self.userName, completion: self.configureView)
				
			}
		}
    
		// Do any additional setup after loading the view.
		customTabBarView.frame.size.width = self.view.frame.width
		customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
		customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
		self.view.addSubview(customTabBarView)
	}
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Show the navigation bar on other view controllers
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
	
//  @IBAction func startSession() {
//    self.startTime = Date.init()
//  }
//
//  func createSessionQuestions(sessionId: Int) -> Void {
//    for answered in self.answeredQuestions {
//      sessionObject?.createSessionQuestion(patientSessionId: sessionId, questionId: answered["questionId"].int!, correct: answered["correct"].bool!)
//    }
//  }
//
//  func endSession() {
//    self.endTime = Date.init()
//    sessionObject?.createSession(startTime: self.startTime, endTime: self.endTime, patientId: self.currentUser["id"].int!, completion: createSessionQuestions)
//  }
	
  @IBAction func unwindToHomeQuizView(segue: UIStoryboardSegue) {
  }
	
	func startLoadingScreen() {
		loadingBackdrop.isHidden = false
		loadingCloud1.isHidden = true
		loadingCloud2.isHidden = true
		loadingCloud3.isHidden = true
		self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.updateLoading), userInfo: nil, repeats: true)
	}
	
	
	
	
	@objc func updateLoading(){
		// still loading
		if (!self.loaded) {
			self.secondsElapsed = (self.secondsElapsed + 1) % 100
			var cloudsDisplay = loadingObject.calculateVisibleClouds(currentSeconds: self.secondsElapsed)
			print(self.secondsElapsed)
			// adjust cloud display based on seconds passed
			switch (cloudsDisplay) {
			case 1:
				loadingBackdrop.isHidden = false
				loadingCloud1.fadeIn()
				loadingCloud2.isHidden = true
				loadingCloud3.isHidden = true
			case 2:
				loadingBackdrop.isHidden = false
				loadingCloud1.isHidden = false
				loadingCloud2.fadeIn()
				loadingCloud3.isHidden = true
			case 3:
				loadingBackdrop.isHidden = false
				loadingCloud1.isHidden = false
				loadingCloud2.isHidden = false
				loadingCloud3.fadeIn()
			default:
				loadingBackdrop.isHidden = false
				loadingCloud1.isHidden = false
				loadingCloud2.isHidden = false
				loadingCloud3.isHidden = false
			}
		}
		// done loading, hide everything
		else {
			loadingBackdrop.fadeOut()
			loadingCloud1.isHidden = true
			loadingCloud2.isHidden = true
			loadingCloud3.isHidden = true
		}

	}
	
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.destination is QuizViewController) {
      let quizVC = segue.destination as! QuizViewController
      quizVC.quizObject = self.quizObject
		quizVC.startTime = Date.init()
		quizVC.patientId = self.currentUser["user_id"].int!
//      quizVC.endTime =
//      quizVC.patientId =
    }
  }
	
	
	
}

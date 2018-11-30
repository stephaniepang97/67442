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
	
	@IBOutlet weak var loadingCloud1 : UILabel!
	@IBOutlet weak var loadingCloud2 : UILabel!
	@IBOutlet weak var loadingCloud3 : UILabel!

	let loadingObject = LoadingScreen()
	var secondsElapsed = 0
	var timer = Timer()
	
	var userName : String = ""
	
	var familyName : String = ""

	var quizObject: QuizViewModel?
	
	var userObject: UserViewModel?
	
	var currentUser : JSON = JSON()
	
	
	func configureView() -> Void {
		// Update the user interface for the detail item.
		self.greetingName.text = "Hi, 8" + self.userName
		if let user: UserViewModel = self.userObject {
			var currentUser = user.currentUser
			self.currentUser = currentUser
			print(self.currentUser)
			print("fuck")
			print(self.currentUser["proper_name"].string!)
			print(self.greetingName.text)
		}
	}
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// start loading screen
		scheduleLoadingScreen()
		// Do any additional setup after loading the view, typically from a nib.
		print(userObject)
		print("fucl")
		userObject?.currentUserFamilyName = self.familyName
		userObject?.currentUserName = self.userName
		// Do any additional setup after loading the view, typically from a nib.
		userObject?.refresh { [unowned self] in
			DispatchQueue.main.async {
				self.userObject!.fetchUser(familyName: self.familyName, userName: self.userName, completion: self.configureView)
			}
		}
	}
	
	func scheduleLoadingScreen() {
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector(("updateCounting")), userInfo: nil, repeats: true)
	}
	
	func updateCounting(){
		self.secondsElapsed = self.secondsElapsed + 1
		var cloudsDisplay = loadingObject.calculateVisibleClouds(currentSeconds: self.secondsElapsed)
		
//		switch (cloudsDisplay) {
//			case 1:
//
//			case 2:
//
//			case 3:
//
//			default:
//
//		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.destination is QuizViewController) {
			let quizVC = segue.destination as! QuizViewController
			quizVC.quizObject = self.quizObject
		}
	}
	
	
	
}

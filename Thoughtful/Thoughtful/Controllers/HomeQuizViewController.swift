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
	
	var userName : String = ""
	
	var familyName : String = ""

	var quizObject: QuizViewModel?
	
	var userObject: UserViewModel?
	
	var currentUser : JSON = JSON()
	
	
	func configureView() -> Void {
		// Update the user interface for the detail item.
		if let user: UserViewModel = self.userObject {
			var currentUser = user.currentUser
			self.currentUser = currentUser
			print(self.currentUser)
		}
	}
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		print(currentUser)
		
		userObject?.currentUserFamilyName = self.familyName
		userObject?.currentUserName = self.userName
		// Do any additional setup after loading the view, typically from a nib.
		userObject?.refresh { [unowned self] in
			DispatchQueue.main.async {
				self.userObject!.fetchUser(familyName: self.familyName, userName: self.userName, completion: self.configureView)
				
			}
		}
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let quizVC = segue.destination as! QuizViewController
		quizVC.quizObject = self.quizObject
	}
	
	
	
}

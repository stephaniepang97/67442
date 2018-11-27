//
//  HomeQuizViewController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/27/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import UIKit

class HomeQuizViewController: UIViewController {
	
	var userName : String = ""
	
	var familyName : String = ""

	var quizObject: QuizViewModel?
	
	var userObject: UserViewModel = UserViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		userObject.fetchUser(familyName: "Pang", userName: "Stephanie Pang")
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let quizVC = segue.destination as! QuizViewController
		quizVC.quizObject = self.quizObject
	}
	
	
	
}

//
//  ViewController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 10/28/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var familyNameInput: UITextField!
	@IBOutlet weak var currentUserInput: UITextField!
  var familyName : String = ""
	

	
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
	self.familyNameInput.delegate = self
	self.currentUserInput.delegate = self

  }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		familyNameInput.resignFirstResponder()
		currentUserInput.resignFirstResponder()
		return true
	}
	

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
	
	
	private func setFamilyName() {
		if let tempFamily = familyNameInput.text {
			self.familyName = tempFamily
		}
	}
	
  @IBAction func startQuiz() {
	setFamilyName()
  }
	
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// set the input data from the storyboard
		setFamilyName()
		if segue.identifier == "QuizStartSegue" {
			let tabBarController = segue.destination as! UITabBarController
			// iterate through navigation controllers
			for navController in tabBarController.viewControllers! {
				print(navController)
				// iterate through view controllers of navigation controllers
				for controller in navController.childViewControllers {
					print(controller)
					// set the user input data, instantiate that model
					if controller is HomeQuizViewController {
						let quizView = controller as! HomeQuizViewController
						quizView.familyName = self.familyName
						quizView.quizObject = QuizViewModel(familyName: self.familyName)
					}
				}

			}
		}
  }
	

	

}


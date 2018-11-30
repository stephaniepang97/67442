//
//  ViewController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 10/28/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var familyNameInput: UITextField!
	@IBOutlet weak var currentUserInput: UITextField!
	var familyName : String = ""
	var userName : String = ""


	
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
	self.familyNameInput.delegate = self
	self.currentUserInput.delegate = self

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
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		familyNameInput.resignFirstResponder()
		currentUserInput.resignFirstResponder()
		return true
	}
	

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
	
	
	private func setInputs() {
		if let tempFamily = familyNameInput.text {
			self.familyName = tempFamily
		}
		if let tempUsername = currentUserInput.text {
			self.userName = tempUsername
		}
	}
	
	
  @IBAction func startQuiz() {
	setInputs()
  }
	
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// set the input data from the storyboard
		setInputs()
		let controller = segue.destination as! HomeQuizViewController
		if controller is HomeQuizViewController {
			let quizView = controller as! HomeQuizViewController
			quizView.familyName = self.familyName
			quizView.userName = self.userName
			quizView.quizObject = QuizViewModel(familyName: self.familyName)
			quizView.userObject = UserViewModel()
		}
  }
	

	

}


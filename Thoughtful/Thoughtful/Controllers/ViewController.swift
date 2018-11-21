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
	var familyName : String = ""
	

	
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
	self.familyNameInput.delegate = self

  }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		familyNameInput.resignFirstResponder()
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
		setFamilyName()
		if segue.identifier == "QuizStartSegue" {
			let showQuiz:QuizViewController = segue.destination as! QuizViewController
			showQuiz.familyName = self.familyName
			showQuiz.quizObject = QuizViewModel(familyName: self.familyName)
		}
	}
	

	

}


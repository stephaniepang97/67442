//
//  ViewController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 10/28/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var familyNameInput: UITextField!
	

	
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
	
  @IBAction func startQuiz() {
	var familyName = ""
	if let tempFamily = familyNameInput.text {
		familyName = tempFamily
	}
	
	
	
  }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "QuizStartSegue" {
			let showQuiz:QuizViewController = segue.destination as! QuizViewController
			showQuiz.familyName = "Temp"
		}
	}
	

	

}


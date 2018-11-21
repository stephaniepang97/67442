//
//  QuizController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/5/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
	var familyName : String = ""
	
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var promptAnswerLabel: UILabel!
	var clickedYes: Bool?
	var showCorrectAnswer: Bool = true
	@IBOutlet weak var imageView: UIImageView!
	
	var quizObject: QuizViewModel?
	var currentQuestion: Question?


	func configureView() -> Void {
		// Update the user interface for the detail item.
		if let quiz: QuizViewModel = self.quizObject {
			var question = quiz.getRandomQuestion()
			self.currentQuestion = question
			if let question = question.question {
				questionLabel.text = question
			}
			if let answer = question.answer {
				var random = Int.random(in: 0...10000) % 2
				// show correct
				if (random == 0) {
					promptAnswerLabel.text = answer + "?"
					self.showCorrectAnswer = true
				}
				// show incorrect
				else {
					promptAnswerLabel.text =  "Wrong ? lmao"
					self.showCorrectAnswer = false
				}
				
			}
			if let picture = question.attachment {
				imageView.image = picture
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(familyName)

		// Do any additional setup after loading the view, typically from a nib.
		quizObject?.refresh { [unowned self] in
			DispatchQueue.main.async {
				self.quizObject!.fetchQuestions(completion: self.configureView)
				
			}
		}
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}
	
	@IBAction func clickedYesButton() {
		self.clickedYes = true
		print("Clicked Yes")
		quizObject?.correctAnswer(question: self.currentQuestion!, clickedYes: true, shownCorrectAnswer: self.showCorrectAnswer)
	}
	
	@IBAction func clickedNoButton() {
		self.clickedYes = false
		print("Clicked No")
		quizObject?.correctAnswer(question: self.currentQuestion!, clickedYes: false, shownCorrectAnswer: self.showCorrectAnswer)
	}
	
	
	
	@IBAction func printQuestion() {
		var question = quizObject?.getRandomQuestion()
		print(question?.question)
		print(question?.answer)
	}
	
	@IBAction func newQuestion() {
		var question = quizObject!.getRandomQuestion()
		self.currentQuestion = question
		questionLabel.text = question.question
		var random = Int.random(in: 0...10000) % 2
		// show correct
		if (random == 0) {
			promptAnswerLabel.text = question.answer + "?"
			self.showCorrectAnswer = true
		}
			// show incorrect
		else {
			promptAnswerLabel.text =  "Wrong ? lmao"
			self.showCorrectAnswer = false
		}
		imageView.image = question.attachment
	}
}


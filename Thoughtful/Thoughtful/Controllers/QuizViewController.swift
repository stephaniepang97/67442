//
//  QuizController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/5/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit
import SwiftyJSON

class QuizViewController: UIViewController {
	
	@IBOutlet weak var loadingBackdrop : UIView!
	@IBOutlet weak var loadingCloud1 : UIImageView!
	@IBOutlet weak var loadingCloud2 : UIImageView!
	@IBOutlet weak var loadingCloud3 : UIImageView!
  
    @IBOutlet var customTabBarView: UIView!
  
	let loadingObject = LoadingScreen()
	var loaded = false
	var secondsElapsed = 0
	var timer = Timer()
	
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var promptAnswerLabel: UILabel!
	var clickedYes: Bool?
	var showCorrectAnswer: Bool = true

	@IBOutlet weak var imageView: UIImageView!
	
	var quizObject: QuizViewModel?
	var currentQuestion: Question?
	
	// session information
	var sessionObject = SessionViewModel()
	var patientId : Int?
	var startTime : Date?
	var endTime : Date?
	var answeredQuestions : [JSON] = []
	
	func configureView() -> Void {
		// Update the user interface for the detail item.
		if let quiz: QuizViewModel = self.quizObject {
			var question = Question()
			if let tempQuestion = self.currentQuestion {
				// skip if image is set
				if let imageSet = tempQuestion.attachment {
					self.loaded = true
					imageView.image = imageSet
					return
				}
				question = tempQuestion
			}
				
			if (quiz.questions.isEmpty) {
				return
			}
				
			else {
				question = quiz.getRandomQuestion()
				self.currentQuestion = question
			}
			
			if let questionText = question.question {
				questionLabel.text = questionText
			}
			if let answer = question.answer {
				var random = Int.random(in: 0...10000) % 4
				// show correct
				if (random <= 2) {
					promptAnswerLabel.text = answer + "?"
					self.showCorrectAnswer = true
				}
				// show incorrect
				else {
					promptAnswerLabel.text =  quizObject?.getRandomAnswer(currentQuestion: question)
					self.showCorrectAnswer = false
				}
			}
			if let picture = question.attachment {
				print("picture")
				imageView.image = picture
				self.loaded = true
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// add custom tab bar
		customTabBarView.frame.size.width = self.view.frame.width
		customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
		customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
		self.view.addSubview(customTabBarView)
    
		// start loading screen
		startLoadingScreen()
		// Do any additional setup after loading the view, typically from a nib.
		quizObject?.refresh { [unowned self] in
			DispatchQueue.main.async {
				self.quizObject!.fetchQuestions(completion: self.configureView)
			}
		}
	}
	
	
	
	func startLoadingScreen() {
		loadingBackdrop.isHidden = false
		loadingCloud1.isHidden = true
		loadingCloud2.isHidden = true
		loadingCloud3.isHidden = true
		self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.updateLoading), userInfo: nil, repeats: true)
	}
	
	@objc func updateLoading(){
		configureView()
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
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}
	
	@IBAction func clickedYesButton() {
		self.clickedYes = true
		print("Clicked Yes")
		var correct = quizObject?.correctAnswer(question: self.currentQuestion!, clickedYes: true, shownCorrectAnswer: self.showCorrectAnswer)
		addQuestion(correct: correct!, questionId: (self.currentQuestion?.id)!)
	}
	
	@IBAction func clickedNoButton() {
		self.clickedYes = false
		print("Clicked No")
		var correct = quizObject?.correctAnswer(question: self.currentQuestion!, clickedYes: false, shownCorrectAnswer: self.showCorrectAnswer)
		addQuestion(correct: correct!, questionId: (self.currentQuestion?.id)!)
	}
	
	func addQuestion(correct: Bool, questionId: Int) {
		let response: JSON = [
			"questionId": questionId,
			"correct": correct
			]
		answeredQuestions.append(response)
		// move to next question
		newQuestion()
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
		var random = Int.random(in: 0...10000) % 4
		// show correct
		if (random <= 2) {
			promptAnswerLabel.text = question.answer + "?"
			self.showCorrectAnswer = true
		}
			// show incorrect
		else {
			promptAnswerLabel.text =  quizObject?.getRandomAnswer(currentQuestion: question)
			self.showCorrectAnswer = false
		}
		imageView.image = question.attachment
		imageView.slowOut()
		imageView.slowIn()

	}
	
	// add session questions
	func submitQuestions(sessionId: Int) {
		for question in answeredQuestions {
			sessionObject.createSessionQuestion(patientSessionId: sessionId, questionId: question["questionId"].int!, correct: question["correct"].bool!)
		}
	}
	
	
	// whenever leaving this view, we want to end the session
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (answeredQuestions.count > 0) {
			self.endTime = Date.init()
			sessionObject.createSession(startTime: self.startTime!, endTime: self.endTime!, patientId: self.patientId!, completion: submitQuestions)
		}
		print(segue.destination)
		
	}
	
}


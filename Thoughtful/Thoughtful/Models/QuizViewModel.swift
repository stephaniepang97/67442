//
//  Quiz.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/21/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class QuizViewModel {
	var questions = [Question]()
	var familyName :String?
	
	func refresh(completion: @escaping () -> Void) {
		fetchQuestions(completion: completion,pictureCallback: {} )
		completion()
	}
	
	func getRandomAnswer(currentQuestion: Question) -> String {
		var questionId = currentQuestion.id
		var count = self.questions.count
		if (count <= 1) {
			return "Temp Wrong Answer"
		}
		var randomIndex = Int.random(in: 0..<count)
		var randomQuestion = self.questions[randomIndex]
		if (randomQuestion.id == currentQuestion.id) {
			return getRandomAnswer(currentQuestion: currentQuestion)
		} else {
			return randomQuestion.answer
		}
	}
	
	init(familyName: String) {
		self.familyName = familyName
	}
	
	func setQuestions(questions: [Question]) {
		self.questions = questions
	}
	
	public func correctAnswer(question: Question, clickedYes: Bool, shownCorrectAnswer: Bool) -> Bool {
		if (clickedYes == shownCorrectAnswer) {
			print("Correct!")
		} else {
			print("Incorrect!")
		}
		return clickedYes == shownCorrectAnswer
		
	}

	
	public func getRandomQuestion() -> Question {
		let totalQuestions = self.questions.count
		let randomIndex = Int.random(in: 0..<totalQuestions)
		return self.questions[randomIndex]
	}
	
	
	public func fetchQuestions(completion: @escaping () -> Void, pictureCallback: @escaping () -> Void) {
		Alamofire.request("https://thoughtfulapi.herokuapp.com/questions").responseJSON { response in
			switch response.result
			{
			case .success:
				print("Request: \(String(describing: response.request))")   // original url request
				print("Response: \(String(describing: response.response))") // http url response
				print("Result: \(response.result)")                         // response serialization result
				var quizQuestions : [Question] = []
				if let json = response.result.value{
					let swiftyJson = JSON(json)
					if let qs = swiftyJson.arrayObject {
						for index in 0..<qs.count {
							let question = Question()
							let q = swiftyJson[index]
							question.id = q["id"].int
							question.question = q["question"].string
							question.answer = q["answer"].string
							question.created_by = q["user"]["user_id"].int
							if let attachmentUrl = q["attachment"]["url"].string {
								let imgUrl = URL(string: attachmentUrl)
								Alamofire.request(imgUrl!).responseData { response in
									print("response from image retrieval: \(String(describing: response))")
									if let data = response.result.value {
										question.attachment = UIImage(data: data)
									}
									pictureCallback()
								}
							}
							print(question.question)
							if let currentFamilyName = q["user"]["family_name"].string {
								if (currentFamilyName == self.familyName) {
									quizQuestions.append(question)
								}
							}
						}
					}
				}
				self.setQuestions(questions: quizQuestions)
        completion()
			case .failure(let error):
				print("Failed to Fetch")
				self.setQuestions(questions: [])
			}
		}
	}
	
	
}


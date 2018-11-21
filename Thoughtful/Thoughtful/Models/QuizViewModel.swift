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
	
	init(familyName: String) {
		setQuestions(familyName: familyName)
	}
	
	public func getRandomQuestion() -> Question {
		let totalQuestions = questions.count
		let randomIndex = Int.random(in: 0..<totalQuestions)
		return questions[randomIndex]
	}

	private func setQuestions(familyName: String) {
		Alamofire.request("https://thoughtfulapi.herokuapp.com/questions").responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result
			
			if let json = response.result.value{
				let swiftyJson = JSON(json)
				if let qs = swiftyJson.arrayObject {
					for index in 0..<qs.count {
						let question = Question()
						let q = swiftyJson[index]
						question.question = q["question"].string
						question.answer = q["answer"].string
						question.created_by = q["user"]["user_id"].int
						let currentFamilyName = q["user"]["family_name"].string

						if let attachmentUrl = q["attachment"]["url"].string {
							let imgUrl = URL(string: "https://thoughtfulapi.herokuapp.com" + attachmentUrl)
							Alamofire.request(imgUrl!).responseData { response in
								print("response from image retrieval: \(String(describing: response))")
								if let data = response.result.value {
									print(response.result)
									question.attachment = UIImage(data: data)
								}
							}
						}
						
						if (currentFamilyName == familyName) {
							self.questions.append(question)
						}
					}
				}
			}
		}
	}
	
	
}


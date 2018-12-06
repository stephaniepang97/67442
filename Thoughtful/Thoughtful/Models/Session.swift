//
//  Session.swift
//  Thoughtful
//
//  Created by Alec Lam on 12/6/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class Session : NSObject {
	
	// MARK: - Properties
	var id: Int!
	var startTime: Date!
	var endTime: Date!
	var totalCorrect: Int
	var totalIncorrect: Int
	var totalAnswered: Int
	var answeredQuestions: [SessionQuestion]
	
	var percentCorrect: Double
	
	// Mark: - General
	init(totalCorrect:Int, totalAnswered:Int, answeredQuestions: [JSON]) {
		self.totalCorrect = totalCorrect
		self.totalAnswered = totalAnswered
		self.totalIncorrect = totalAnswered - totalCorrect
		self.percentCorrect = (Double(totalCorrect) / Double(self.totalIncorrect)) * 100

		
		var result : [SessionQuestion] = []
		for question in answeredQuestions {
			var object = SessionQuestion()
			var questionDetails = question["question_details"]
			object.id = questionDetails["id"].int
			object.answer = questionDetails["answer"].string
			object.correct = question["correct"].bool
			
			var url = questionDetails["attachment"].string

			if let attachmentUrl = url {
				let imgUrl = URL(string: attachmentUrl)
				Alamofire.request(imgUrl!).responseData { response in
					print("response from image retrieval: \(String(describing: response))")
					if let data = response.result.value {
						object.attachment = UIImage(data: data)
					}
				}
			}
			result.append(object)
		}
		self.answeredQuestions = result
		
		
	}
	
}

//
//  UserAnalyticsViewModel.swift
//  Thoughtful
//
//  Created by Alec Lam on 12/6/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAnalyticsViewModel {
	
	public func getPatientDataFromFamilyName(familyName: String, completion: @escaping (JSON) -> Void) {
		Alamofire.request("https://thoughtfulapi.herokuapp.com/families").responseJSON { response in
			switch response.result
			{
				case .success(let jsonResponse):
					let swifty = JSON(jsonResponse)
					// got through families
					for i in 0..<swifty.count {
						var family = swifty[i]
						// go through users if we are at our current family
						if (family["family_name"].string == familyName) {
							var users = family["users"].array!
							for user in users {
								var role = user["role"]
								if (role == "patient") {
									return self.getDataForUser(user: user, completion: completion)
								}
							}
						}
					}
				case .failure(let error):
					print("Failed to Fetch")
			}
		}
	}
	
	
	
	private func getDataForUser(user: JSON, completion: (JSON) -> Void) {
		var userId = user["user_id"].int
		Alamofire.request("https://thoughtfulapi.herokuapp.com/patient_sessions").responseJSON { response in
		switch response.result
			{
			case .success(let jsonResponse):
				var sessions : [Session] = []
				let swifty = JSON(jsonResponse)
				// got through all patient sessions, if they match the provided user, save to array
				for i in 0..<swifty.count {
					var currentSession = swifty[i]
					if (currentSession["user"] == user) {
						
						// *** MAKE SESSION OBJECT MODEL
						var correctCount = currentSession["total_correct"].int!
						var answeredCount = currentSession["total_answered"].int!
						var questions = currentSession["session_questions"].array!

						var session = Session(totalCorrect: correctCount, totalAnswered: answeredCount,answeredQuestions: questions)
						
						sessions.append(session)
					}
				}
				
				// *** PARSE DATA TO PRESENT BACK TO VIEW
				var data = JSON()
				for session in sessions {
					
				}
				
				print("Fetched!")
			case .failure(let error):
				print("Failed to Fetch")
			}
		}
		
	}
	
	

	
	
}

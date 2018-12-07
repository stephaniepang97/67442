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
	
	var familyName = ""
	var patientName = ""

	var currentData : JSON = JSON()

	func refresh(completion: @escaping () -> Void) {
		getPatientDataFromFamilyName(familyName: self.familyName, completion: completion)
	}
	
	
	public func getPatientDataFromFamilyName(familyName: String, completion: @escaping () -> Void) {
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
							let users = family["users"].array!
							for user in users {
								let role = user["role"]
								let name = user["proper_name"]
								if (role == "patient") {
									print("got patient data!!!!")
									self.patientName = name.string!
									print(user)
									print("--")
									self.getDataForUser(user: user, completion: completion)
								}
							}
						}
					}
				case .failure(let error):
					print("Failed to Fetch")
			}
		}
	}
	
	
	
	private func getDataForUser(user: JSON, completion: @escaping () -> Void) {
		var userId = user["user_id"].int
		self.patientName = user["proper_name"].string!
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
						var startTimeString = currentSession["start_time"].string!
						var endTimeString = currentSession["end_time"].string!
						
						// adjust to the
						
						let dateFormatter = DateFormatter()
						// "start_time": "2018-12-06T19:41:02.000Z"
						print(endTimeString)
						dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
						dateFormatter.locale = Locale(identifier: "en_US")
						let endDate = dateFormatter.date(from: endTimeString)!
						let startDate = dateFormatter.date(from: startTimeString)!

						session.id = currentSession["id"].int!
						session.endTime = endDate
						session.startTime = startDate
						
						sessions.append(session)
					}
				}
				
				// *** PARSE DATA TO PRESENT BACK TO VIEW
				print("collected sessions!")
				self.parseSessionData(sessions: sessions, completion: completion)

				
				print("Fetched!")
			case .failure(let error):
				print("Failed to Fetch")
			}
		}
		
	}
	
	private func getIncorrectQuestions(sessions: [Session]) -> [SessionQuestion]{
		var incorrect : [SessionQuestion]  = []
		for session in sessions {
			let currentQuestions = session.answeredQuestions
			for question in currentQuestions {
				if (question.correct == false) {
					incorrect.append(question)
				}
			}
		}
		print("got incorrect questions")
		print(incorrect)
		return incorrect
	}
	
	
	private func parseSessionData(sessions: [Session], completion: () -> Void) {

		var recentSessions = getThreeRecentSessions(sessions: sessions)
		
		var incorrectQuestions = getIncorrectQuestions(sessions: recentSessions)
		
		var data : JSON = [
			"recent_sessions":recentSessions,
			"incorrect_questions":incorrectQuestions,
			"name": self.patientName
		]
		print("parsed data!")
		self.currentData = data
		
		completion()
	}
	
	// returns true if session1 is more recent than session 2, otherwise, false
	private func isMoreRecentSession(session1: Session, session2: Session) -> Bool {
		if (session1.endTime > session2.endTime) {
			return true
		} else {
			return false
		}
	}
	
	// return the most recent sessions
	private func getThreeRecentSessions(sessions: [Session]) -> [Session] {
		// if only one, or no sessions
		if (sessions.count  <= 1) {
			return sessions
		}
		// two sessions
		else if (sessions.count == 2) {
			if (isMoreRecentSession(session1: sessions[0], session2: sessions[1])) {
				return sessions
			} else {
				return sessions.reversed()
			}
		}
		// three sessions
		else if (sessions.count == 3) {
			// reorder the session
			let first : Session = sessions[0]
			let second : Session = sessions[1]
			let third : Session = sessions[2]
			var result : [Session] = []
			// check first against all others
			if (isMoreRecentSession(session1: first, session2: second) && isMoreRecentSession(session1: first, session2: third)) {
				result.append(first)
				if (isMoreRecentSession(session1: second, session2: third)) {
					result.append(second)
					result.append(third)
				} else {
					result.append(third)
					result.append(second)
				}
			}
			// check second against all others
			else if (isMoreRecentSession(session1: second, session2: first) && isMoreRecentSession(session1: second, session2: third)){
				result.append(second)
				if (isMoreRecentSession(session1: first, session2: third)) {
					result.append(first)
					result.append(third)
				} else {
					result.append(third)
					result.append(first)
				}
			}
			// third is more recent than all
			else {
				result.append(third)
				if (isMoreRecentSession(session1: first, session2: second)) {
					result.append(first)
					result.append(second)

				} else {
					result.append(second)
					result.append(first)
				}
			}
			return result
		}
		// more than 3 sessions in the array
		else {
			var firstRecent : Session? = nil
			var secondRecent : Session? = nil
			var thirdRecent : Session? = nil
			var setCount = 0
			
			for session in sessions {
				// set session code
				switch (setCount) {
					case (0):
						firstRecent = session
						setCount += 1
					case (1):
						// check first
						if (isMoreRecentSession(session1: session, session2: firstRecent!)) {
							secondRecent = firstRecent
							firstRecent = session
						} else {
							secondRecent = session
						}
						setCount += 1
					case (2):
						// check if more than first
						if (isMoreRecentSession(session1: session, session2: firstRecent!)) {
							thirdRecent = secondRecent
							secondRecent = firstRecent
							firstRecent = session
						}
						// check if more than second
						else if (isMoreRecentSession(session1: session, session2: secondRecent!)) {
							thirdRecent = secondRecent
							secondRecent = session
						} else {
							thirdRecent = session
						}
						setCount += 1
					
					// three have already been set, need to compare against all of them
					default:
						// check if more than first
						if (isMoreRecentSession(session1: session, session2: firstRecent!)) {
							thirdRecent = secondRecent
							secondRecent = firstRecent
							firstRecent = session
							setCount += 1
						}
						// check if more than second
						else if (isMoreRecentSession(session1: session, session2: secondRecent!)) {
							thirdRecent = secondRecent
							secondRecent = session
							setCount += 1
						}
						// check if more than third
						else if (isMoreRecentSession(session1: session, session2: thirdRecent!)) {
							thirdRecent = session
							setCount += 1
						}
						else {
							thirdRecent = session
						}
				}
			}
			var result : [Session] = [firstRecent!,secondRecent!,thirdRecent!]
			return result
		}
	}
	
	

	
	
}

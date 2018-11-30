//
//  SessionViewModel.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/30/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SessionViewModel {
	
	public func createSessionQuestion(patientSessionId: Int, questionId: Int, correct: Bool) -> Void {
		let parameters: Parameters = [
			"patient_session_id": patientSessionId,
			"question_id": questionId,
			"correct": correct,
			]
		print(parameters)
		Alamofire.request("https://thoughtfulapi.herokuapp.com/session_questions", method: .post, parameters: parameters).responseJSON { response in
			switch response.result {
			case .success(let responseJson):
				print("Created Session Question")
				print(responseJson)
			case .failure(let error):
				print("Failed Creating Session Question")
			}
		}
	}
	
	public func createSession(startTime: Date, endTime: Date, patientId: Int, completion: @escaping (Int) -> Void) {
		let parameters: Parameters = [
				"start_time": startTime,
				"end_time": endTime,
				"patient_id": patientId,
			]
		print(parameters)
		Alamofire.request("https://thoughtfulapi.herokuapp.com/patient_sessions", method: .post, parameters: parameters).responseJSON { response in
			switch response.result {
				case .success(let responseJson):
					print("Created Session")
					print(responseJson)
					let result = JSON(responseJson)
					completion(result["id"].int!)
				case .failure(let error):
					print("Failed Creating Session")
			}
		}
	}
}


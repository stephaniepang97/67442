//
//  User.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/21/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserViewModel {
	var recentStatus = false;
	
	var currentUser : JSON = JSON()
	
	var currentUserFamilyName = ""
	var currentUserName = ""

	func refresh(completion: @escaping () -> Void) {
		fetchUser(familyName: self.currentUserFamilyName, userName: self.currentUserName, completion: completion)
	}
	
	func fetchUser(familyName: String, userName: String, completion: @escaping () -> Void) {
		print("Fetching User (Family Name + First Name)..")
		Alamofire.request("https://thoughtfulapi.herokuapp.com/families").responseJSON {
			response in switch response.result {
				case .success(let jsonData):
					let families = response.result.value
					let swifty = JSON(families as Any).arrayObject
					var targetFamily : JSON? = nil
					var targetUser : JSON? = nil
					// get the family we are looking for
					if let swiftySafe = swifty {
						for index in 0..<swiftySafe.count {
							var family = JSON(swiftySafe[index])
							let currentFamilyName = family["family_name"].string
							let currentFamilyId = family["family_id"].int!
							if  (familyName == currentFamilyName) {
								targetFamily = family
								break
							}
						}
					}
					// access that family
					if let currentFamily = targetFamily {
						// go through all users in that family. return the user that matches the first name
						let users = currentFamily["users"]
						for user in users {
							let userIndex = user.0
							let userData = user.1
							let currentName = userData["proper_name"].string
							// set the target user if it matches the name
							if (currentName == userName) {
								targetUser = userData
							}
						}
					}
					
					if let safeUser = targetUser {
						self.currentUser = safeUser
						completion()
					} else {
						// failure()
					}
					
				case .failure(let error):
					self.recentStatus = false
			}

		}
	
	}
	
	
	
	func createUser(firstName: String, lastName: String, familyName: String, role: String) -> Bool {
		print("Creating User..")
		var result = true
		
		Alamofire.request("https://thoughtfulapi.herokuapp.com/families").responseJSON { response in
			var familyId = -1
			let families = response.result.value
			let swifty = JSON(families as Any).arrayObject
			if let swiftySafe = swifty {
				for index in 0..<swiftySafe.count {
					var family = JSON(swiftySafe[index])
					let currentFamilyName = family["family_name"].string
					let currentFamilyId = family["family_id"].int!
					if  (familyName == currentFamilyName) {
						familyId = currentFamilyId
						break
					}
				}
			}
			let parameters: Parameters = [
				"first_name": firstName,
				"last_name": lastName,
				"family_id": familyId,
				"role": role.lowercased()
			]
			print(parameters)
			Alamofire.request("https://thoughtfulapi.herokuapp.com/users", method: .post, parameters: parameters).responseJSON
				{ response in switch response.result {
				case .success(let jsonData):
					print(jsonData)
					self.recentStatus = true
				case .failure(let error):
					self.recentStatus = false
					// failure()
				}
			}
			
		}
		return result
	}
}

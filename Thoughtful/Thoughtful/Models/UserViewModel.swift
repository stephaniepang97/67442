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
					self.recentStatus = true
				case .failure(let error):
					self.recentStatus = false
					}
			}
			
		}
		return result
	}
}

//
//  CreateUserController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/5/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreateUserController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var rolePicker: UIPickerView!
	@IBOutlet weak var firstNameInput: UITextField!
	@IBOutlet weak var lastNameInput: UITextField!
	@IBOutlet weak var familyNameInput: UITextField!

	var selectedValue : String = ""
	var roleData: [String] = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		roleData = ["Patient", "Caretaker", "Doctor"]
		self.selectedValue = roleData[0]
		// connector
		self.rolePicker.delegate = self
		self.rolePicker.dataSource = self
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.

	}
	
	// Number of columns of data
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	// The number of rows of data
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return roleData.count
	}
	
	// The data to return fopr the row and component (column) that's being passed in
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return roleData[row]
	}
	
	// Capture the picker view selection
	func pickerView(_ pickerView: UIPickerView, didSelectRow inComponent: Int, inComponent component: Int) {
		// This method is triggered whenever the user makes a change to the picker selection.
		// The parameter named row and component represents what was selected.
		self.selectedValue = roleData[inComponent]
	}
	
	@IBAction func createUserRequest() {
		print("hi")
		var familyName = ""
		if let temp = familyNameInput.text {
			familyName = temp
		}
		
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
				"first_name": self.firstNameInput.text!,
				"last_name": self.lastNameInput.text!,
				"family_id": familyId,
				"role": self.selectedValue.lowercased()
			]
			print(parameters)
			Alamofire.request("https://thoughtfulapi.herokuapp.com/users", method: .post, parameters: parameters).responseJSON
				{ response in print(response)
			}

		}
		
		

		// All three of these calls are equivalent
//		Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
	}
	
	
}


//
//  CreateUserController.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/5/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit


class CreateUserController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var rolePicker: UIPickerView!
	@IBOutlet weak var firstNameInput: UITextField!
	@IBOutlet weak var lastNameInput: UITextField!
	@IBOutlet weak var familyNameInput: UITextField!

	var selectedValue : String = ""
	var roleData: [String] = [String]()
	
	var userObject : UserViewModel = UserViewModel()
	
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
		print("clicked")
		
		var firstName = ""
		var lastName = ""
		var familyName = ""
			
		if let tempFirst = firstNameInput.text {
			firstName = tempFirst
		}
		if let tempLast = lastNameInput.text {
			lastName = tempLast
		}
		if let tempFamily = familyNameInput.text {
			familyName = tempFamily
		}


		self.userObject.createUser(firstName: firstName, lastName: lastName, familyName: familyName, role: self.selectedValue)
		
		print(userObject.recentStatus)

		self.navigationController?.popViewController(animated: true)

		
	}
	
	
}


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
	
	var roleData: [String] = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		roleData = ["Patient", "Caretaker", "Doctor"]
		
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
	
	func createUserRequest() {
		let parameters: Parameters = [
			"foo": "bar",
			"baz": ["a", 1],
			"qux": [
				"x": 1,
				"y": 2,
				"z": 3
			]
		]
		
		// All three of these calls are equivalent
		Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
	}
	
	
}


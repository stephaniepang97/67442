//
//  Session.swift
//  Thoughtful
//
//  Created by Alec Lam on 12/6/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import UIKit

class Session: NSObject {
	
	// MARK: - Properties
	var id: Int!
	var startTime: Date!
	var endTime: Date!
	var totalCorrect: Int!
	var totalIncorrect: Int!
	var totalAnswered: Int!
	var answeredQuestions: [SessionQuestion]!
	
	var percentCorrect: Double!
	
	// Mark: - General
	
	override init(){
		super.init()
	}
	
}

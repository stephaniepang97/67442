//
//  ThoughtfulTests.swift
//  ThoughtfulTests
//
//  Created by Stephanie Pang on 10/28/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import XCTest
@testable import Thoughtful

class ThoughtfulTests: XCTestCase {
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		let userModel = UserViewModel()
		let badQuestionModel = QuestionViewModel(familyName: "")
		let questionModel = QuestionViewModel(familyName: "Lam")
		let loadingModel = LoadingScreen()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	
	func testCompletion() -> Void {
		XCTAssert(true)
		return
	}
	

	// test UserAnalyticsViewModel
	func testAnalytics() {
		let analyticsModel = UserAnalyticsViewModel()
		// test data or patient
		analyticsModel.getPatientDataFromFamilyName(familyName: "Lam", completion: testCompletion)
		analyticsModel.refresh(completion: testCompletion)
		analyticsModel.getPatientDataFromFamilyName(familyName: "", completion: testCompletion)
	}
	
	// test QuizViewModel
	func testQuiz() {
	
		let badQuizModel = QuizViewModel(familyName: "")
		let quizModel = QuizViewModel(familyName: "Lam")
		badQuizModel.fetchQuestions(completion: testCompletion, pictureCallback: testCompletion)
		badQuizModel.refresh(completion: testCompletion)
		let badQuestion : Question? = badQuizModel.getRandomQuestion()
		XCTAssertNil(badQuestion)
		quizModel.fetchQuestions(completion: testCompletion, pictureCallback: testCompletion)
		quizModel.refresh(completion: testCompletion)
		
		
		let expect = expectation(description: "Quiz Alamofire")
		
		expect.expectedFulfillmentCount = 2
		
		quizModel.refresh(completion: {
			expect.fulfill()
		})
		
		waitForExpectations(timeout: 1000.0, handler: nil)
		
		let question : Question? = quizModel.getRandomQuestion()
		
		let answer : String? = quizModel.getRandomAnswer(currentQuestion: question!)
		XCTAssert(answer != nil)
		badQuizModel.correctAnswer(question: question!, clickedYes: true, shownCorrectAnswer: true)

	}
	
	// test SessionViewModel
	func testSession() {
		let sessionModel = SessionViewModel()
//		sessionModel.createSession(startTime: <#T##Date#>, endTime: <#T##Date#>, patientId: <#T##Int#>, completion: <#T##(Int) -> Void#>)
//		sessionModel.createSessionQuestion(patientSessionId: <#T##Int#>, questionId: <#T##Int#>, correct: <#T##Bool#>)
	}
	
	// test UserViewModel
	func testUser() {
		let userModel = UserViewModel()

//		userModel.createUser(firstName: <#T##String#>, lastName: <#T##String#>, familyName: <#T##String#>, role: <#T##String#>)
//		userModel.fetchUser(familyName: <#T##String#>, userName: <#T##String#>, completion: <#T##() -> Void#>, failure: <#T##() -> Void#>)
//		userModel.refresh(completion: <#T##() -> Void#>, failure: <#T##() -> Void#>)
		
	}
	
	// test LoadingScreen
	func testLoading() {
		
	}
    
}

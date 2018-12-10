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
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testCompletion() -> Void {
		XCTAssert(true)
		return
	}
	
	func testFail() -> Void {
		XCTAssert(true)
		return
	}
	

  // MARK: test UserAnalyticsViewModel
	func testAnalytics() {
		let analyticsModel = UserAnalyticsViewModel()
		// test data or patient
		analyticsModel.getPatientDataFromFamilyName(familyName: "Lam", completion: testCompletion)
		analyticsModel.refresh(completion: testCompletion)
		analyticsModel.getPatientDataFromFamilyName(familyName: "", completion: testCompletion)
	}
	
	// MARK: test QuizViewModel
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
	
	// MARK: test SessionViewModel
	func testSession() {
		let sessionModel = SessionViewModel()
		sessionModel.createSession(startTime: Date.init(), endTime: Date.init(), patientId: 1, completion: {x in
			self.testCompletion()
		})
		sessionModel.createSession(startTime: Date.init(), endTime: Date.init(), patientId: 1, completion: {x in
			self.testCompletion()
		})
	}
	
	// MARK: test UserViewModel
	func testUser() {
		let userModel = UserViewModel()
		userModel.fetchUser(familyName: "Lam", userName: "Alec Lam", completion: testCompletion, failure: testFail)
		userModel.fetchUser(familyName: "", userName: "Alec Lam", completion: testCompletion, failure: testFail)
		userModel.fetchUser(familyName: "Lam", userName: "", completion: testCompletion, failure: testFail)
		userModel.fetchUser(familyName: "", userName: "", completion: testCompletion, failure: testFail)
		userModel.refresh(completion: testCompletion, failure: testFail)
	}
	
	// MARK: test LoadingScreen
	func testLoading() {
		let loadingModel = LoadingScreen()
		let a = loadingModel.calculateVisibleClouds(currentSeconds: 0)
		let b = loadingModel.calculateVisibleClouds(currentSeconds: 2)
		let c = loadingModel.calculateVisibleClouds(currentSeconds: 5)
		let d = loadingModel.calculateVisibleClouds(currentSeconds: 8)
		let e = loadingModel.calculateVisibleClouds(currentSeconds: 11)
		
		XCTAssertEqual(a, 1)
		XCTAssertEqual(b, 1)
		XCTAssertEqual(c, 2)
		XCTAssertEqual(d, 3)
		XCTAssertEqual(e, 0)
	}
  
  // MARK: test QuizViewModel
  func createQuestion() -> Question {
    return Question(id: 1,
                    question: "Who is this?",
                    answer: "Stephanie Pang",
                    created_by: 1,
                    attachment: UIImage(named: "thoughtfulLogo"))
  }
  
  func test_numberOfRows() {
    let questions = [createQuestion(), createQuestion(), createQuestion()]
    let viewModel = QuestionViewModel(familyName: "Pang")
    viewModel.questions = questions
    
    XCTAssertEqual(viewModel.numberOfRows(), 3)
  }
  
  func test_addingQuestion() {
    let viewModel = QuestionViewModel(familyName: "Pang")
    viewModel.loadQuestions(tableViewController: nil)
    let size = viewModel.numberOfRows()
    
    let question = createQuestion()
    viewModel.saveQuestion(question: question)
    viewModel.loadQuestions(tableViewController: nil)
    XCTAssertEqual(viewModel.numberOfRows(), size+1)
  }
  
    
}

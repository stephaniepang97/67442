//
//  AddQuestionController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/4/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit
import Foundation
import Photos
import CoreData

// MARK: Protocol Methods

protocol AddQuestionControllerDelegate: class {
  func addQuestionControllerDidCancel(controller: AddQuestionController)
  
  func addQuestionController(controller: AddQuestionController, didFinishAddingQuestion question: Question)
}

// MARK: - AddQuestionController
class AddQuestionController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var picPreview: UIImageView!
  
    @IBOutlet var customTabBarView: UIView!
  
    // MARK: - Properties
    weak var delegate: AddQuestionControllerDelegate?
    let imagePicker = UIImagePickerController()
    var picture: UIImage?
  
  // MARK: - Text Delegates
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.questionField.delegate = self
      self.answerField.delegate = self

      PHPhotoLibrary.requestAuthorization({_ in return})
      imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
      
      customTabBarView.frame.size.width = self.view.frame.width
      customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
      customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
      self.view.addSubview(customTabBarView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      questionField.becomeFirstResponder()
    }
  
    // MARK: - Actions
    @IBAction func cancel() {
      delegate?.addQuestionControllerDidCancel(controller: self)
    }
  
    @IBAction func done() {
      let question = Question()
      question.question = questionField.text!
      question.answer = answerField.text!
      question.created_by = 1
      question.attachment = picture
      saveQuestion(question: question)
      if question.question.count > 0 {
        delegate?.addQuestionController(controller: self, didFinishAddingQuestion: question)
      }
  }

  // MARK: - Table View
  
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  @IBAction func loadImageButtonTapped(sender: UIButton) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      picture = pickedImage
      picPreview.image = picture
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  func saveQuestion(question: Question){
    // Connect to the context for the container stack
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    // Specifically select the People entity to save this object to
    let entity = NSEntityDescription.entity(forEntityName: "SavedQuestion", in: context)
    let newQuestion = NSManagedObject(entity: entity!, insertInto: context)
    // Set values one at a time and save
    newQuestion.setValue(question.question, forKey: "question")
    newQuestion.setValue(question.answer, forKey: "answer")
    newQuestion.setValue(question.created_by, forKey: "created_by")
    // Safely unwrap the picture
    if let pic = question.attachment {
      newQuestion.setValue(UIImagePNGRepresentation(pic), forKey: "attachment")
    }
    do {
      try context.save()
    } catch {
      print("Failed saving")
    }
  }

}

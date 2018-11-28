import UIKit
//: Playground - noun: a place where people can play
// https://newfivefour.com/swift-form-data-multipart-upload-URLRequest.html

import Foundation
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true

extension NSMutableData {
  func appendString(_ string: String) {
    let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
    append(data!)
  }
}

func createBody(parameters: [String: String],
                boundary: String,
                data: Data,
                mimeType: String,
                filename: String) -> Data {
  let body = NSMutableData()
  
  let boundaryPrefix = "--\(boundary)\r\n"
  
  for (key, value) in parameters {
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
    body.appendString("\(value)\r\n")
  }
  
  body.appendString(boundaryPrefix)
  body.appendString("Content-Disposition: form-data; name=\"attachment\"; filename=\"\(filename)\"\r\n")
  body.appendString("Content-Type: \(mimeType)\r\n\r\n")
  body.append(data)
  body.appendString("\r\n")
  body.appendString("--".appending(boundary.appending("--")))
  
  return body as Data
}


var r  = URLRequest(url: URL(string: "http://localhost:3000/questions")!)
r.httpMethod = "POST"
let boundary = "Boundary-\(UUID().uuidString)"
r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

var params = [
  "question": "Whose face is this?",
  "answer": "Stephanie Pang",
  "created_by": "1"
]
r.httpBody = createBody(parameters: params,
                        boundary: boundary,
                        data: (UIImage(named: "steph.jpg")?.jpegData(compressionQuality: 0.7))!,
                        mimeType: "image/jpg",
                        filename: "steph.jpg")

//NSURLConnection.sendAsynchronousRequest(r, queue: OperationQueue.main) {(response, data, error) in
//  guard let data = data else { return }
//  print(String(data: data, encoding: .utf8)!)
//}


// get photo back
struct Question: Decodable {
  let question: String
  let answer: String
  let attachment: Attachment
  let created_by: Int
}

struct Attachment: Decodable {
  let url: String
}


let url = "http://localhost:3000/questions/2"

let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
  guard let data = data else {
    print("Error: No data to decode")
    return
  }
  
  guard let question = try? JSONDecoder().decode(Question.self, from: data) else {
    print("Error: Couldn't decode data into a question")
    return
  }
  
  print(question.question)
  print(question.answer)
  print(question.created_by)
  print(question.attachment.url)
  
}

task.resume()




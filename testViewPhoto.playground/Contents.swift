//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

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

class MyViewController : UIViewController {
    
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
    
    let label = UILabel()
    
    view.addSubview(label)
    self.view = view
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
    view.addSubview(imageView)
    
    let imgUrl = URL(string: "http://thoughtfulapi.herokuapp.com/uploads/question/attachment/2/steph.jpg")
    let imgData = try? Data(contentsOf: imgUrl!)
    imageView.image = UIImage(data: imgData!)

  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

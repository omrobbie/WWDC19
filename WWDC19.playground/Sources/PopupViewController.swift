import UIKit
import PlaygroundSupport

public class PopupViewController: UIViewController {
    
    let dismissButton:UIButton! = UIButton(type:.custom)
    
    var imageName = "bg"
    var textTitle = "Memory Game"
    var textLocation = "Indonesia"
    var textDescription = "This is the game that I prepared in the very short time for WWDC19 Scholarship. I hope you can accept this."
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        setupImage()
        setupTitle()
        setupLocation()
        setupDescription()
    }
    
    func setupButton() {
        let normal = UIControl.State(rawValue: 0)
        
        dismissButton.setTitle("Click to dismiss", for: normal)
        dismissButton.setTitleColor(UIColor.white, for: normal)
        dismissButton.backgroundColor = UIColor.blue
        dismissButton.titleLabel!.font = UIFont(name: "Helvetica", size: 16)
        dismissButton.titleLabel?.textAlignment = .left
        dismissButton.layer.cornerRadius = 15
        dismissButton.frame = CGRect(
            x:20,
            y:20,
            width:545,
            height:50
        )
        dismissButton.addTarget(self,action: #selector(self.pizzaDidFinish),for: .touchUpInside)
        view.addSubview(dismissButton)
    }
    
    func setupImage() {
        let myImage: UIImage! = UIImage(named: imageName)
        let myImageView = UIImageView(image: myImage)
        
        myImageView.frame = view.frame
        myImageView.frame = CGRect(
            x: 20,
            y: 80,
            width: 120,
            height: 141
        )
        view.addSubview(myImageView)
    }
    
    func setupTitle() {
        let myTitle = UILabel()

        myTitle.text = textTitle
        myTitle.frame = CGRect(
            x: 151,
            y: 65,
            width: 414,
            height: 50
        )
        myTitle.font = UIFont(name: "Helvetica", size: 24)
        myTitle.font = myTitle.font.bold
        myTitle.textAlignment = .left
        view.addSubview(myTitle)
    }
    
    func setupLocation() {
        let myLocation = UILabel()
        
        myLocation.text = textLocation
        myLocation.frame = CGRect(
            x: 151,
            y: 85,
            width: 414,
            height: 50
        )
        myLocation.font = UIFont(name: "Helvetica", size: 14)
        myLocation.font = myLocation.font.italic
        myLocation.textAlignment = .left
        view.addSubview(myLocation)
    }
    
    func setupDescription() {
        let myDescription = UILabel()

        myDescription.text = textDescription
        myDescription.frame = CGRect(
            x: 151,
            y: 140,
            width: 414,
            height: 505
        )
        myDescription.font = UIFont(name: "Helvetica", size: 16)
        myDescription.textAlignment = .left
        myDescription.numberOfLines = 0
        myDescription.sizeToFit()
        view.addSubview(myDescription)
    }
    
    @objc func pizzaDidFinish(){
        dismiss(animated: true, completion: nil)
    }
}

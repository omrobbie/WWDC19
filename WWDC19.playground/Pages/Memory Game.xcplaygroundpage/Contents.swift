import PlaygroundSupport
import UIKit

let vc = GameViewController()

PlaygroundPage.current.liveView = vc
//: Change card back image here.
vc.backImage = UIImage(named: "bg")!
//: Change card padding here.
vc.padding = 20

//: [<< Go back](@previous)

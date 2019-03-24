import UIKit

public class Card: UIImageView {
    public let x: Int
    public let y: Int
    
    public init(image: UIImage?, x: Int, y: Int) {
        self.x = x
        self.y = y
        super.init(image: image)
        
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10.0
        self.isUserInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

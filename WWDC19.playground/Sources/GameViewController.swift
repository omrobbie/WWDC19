import UIKit
import PlaygroundSupport
import GameplayKit

let cardWidth = CGFloat(120)
let cardHeight = CGFloat(141)

public class GameViewController: UIViewController {
    
    public var padding = CGFloat(20) {
        didSet {
            resetGrid()
        }
    }
    
    public var backImage: UIImage = UIImage(
        color: .red,
        size: CGSize(width: cardWidth, height: cardHeight)
    )!
    
    var viewWidth: CGFloat {
        get {
            return 4 * cardWidth + 5 * padding
        }
    }
    
    var viewHeight: CGFloat {
        get {
            return 4 * cardHeight + 5 * padding
        }
    }
    
    var shuffledNumbers = [Int]()
    var firstCard: Card?
    var matchCard: Int = 0
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        preferredContentSize = CGSize(width: viewWidth, height: viewHeight)
        
        shuffle()
        setupGrid()
        closeTheCard()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(GameViewController.handleTap(gr:))
        )
        view.addGestureRecognizer(tap)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = UIView()
        view.backgroundColor = .yellow
        view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
    }
    
    func shuffle() {
        let numbers = (1...8).flatMap{[$0, $0]}
        
        shuffledNumbers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]
    }
    
    func cardNumberAt(_ x: Int, _ y: Int) -> Int {
        assert(0 <= x && x < 4 && 0 <= y && y < 4)

        return shuffledNumbers[4 * x + y]
    }

    func centerOfCardAt(_ x: Int, _ y: Int) -> CGPoint {
        assert(0 <= x && x < 4 && 0 <= y && y < 4)
        let (w, h) = (cardWidth + padding, cardHeight + padding)
        
        return CGPoint(
            x: CGFloat(x) * w + w/2 + padding/2,
            y: CGFloat(y) * h + h/2 + padding/2
        )
    }
    
    func closeTheCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for v in self.view.subviews {
                if let card = v as? Card {
                    UIView.transition(
                        with: card,
                        duration: 1.0,
                        options: .transitionFlipFromLeft,
                        animations: {card.image =  self.backImage},
                        completion: nil
                    )
                }
            }
        }
    }
    
    func setupGrid() {
        matchCard = 0
        
        for i in 0..<4 {
            for j in 0..<4 {
                let n = cardNumberAt(i, j)
                let card = Card(image: UIImage(named: String(n)), x: i, y: j)
                
                card.tag = n
                card.center = centerOfCardAt(i, j)
                view.addSubview(card)
            }
        }
    }
    
    func resetGrid() {
        matchCard = 0
        view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        
        for v in view.subviews {
            if let card = v as? Card {
                card.center = centerOfCardAt(card.x, card.y)
            }
        }
    }
    
    func resetGame() {
        matchCard = 0
        
        for view in self.view.subviews{
            view.removeFromSuperview()
        }

        shuffle()
        setupGrid()
        closeTheCard()
    }
    
    @objc func handleTap(gr: UITapGestureRecognizer) {
        let v = view.hitTest(gr.location(in: view), with: nil)!
        
        if let card = v as? Card {
            playSoundClick()
            
            UIView.transition(
                with: card, duration: 0.5,
                options: .transitionFlipFromLeft,
                animations: {card.image = UIImage(named: String(card.tag))}
            ) {_ in card.isUserInteractionEnabled = false
                if let pCard = self.firstCard {
                    if pCard.tag == card.tag {
                        self.matchCard += 1
                        playSoundMatch()
                        
                        UIView.animate(
                            withDuration: 0.5,
                            animations: {card.alpha = 0.0},
                            completion: {_ in card.removeFromSuperview()}
                        )
                        
                        UIView.animate(
                            withDuration: 0.5,
                            animations: {pCard.alpha = 0.0},
                            completion: {_ in pCard.removeFromSuperview()}
                        )
                        
                        let vc = PopupViewController()

                        vc.imageName = String(card.tag)
                        vc.textTitle = myList[card.tag-1][0]
                        vc.textLocation = myList[card.tag-1][1]
                        vc.textDescription = myList[card.tag-1][2]
                        
                        vc.view.backgroundColor = UIColor.yellow
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        UIView.transition(
                            with: card,
                            duration: 0.5,
                            options: .transitionFlipFromLeft,
                            animations: {card.image = self.backImage}
                        ) {_ in card.isUserInteractionEnabled = true}
                        
                        UIView.transition(
                            with: pCard,
                            duration: 0.5,
                            options: .transitionFlipFromLeft,
                            animations: {pCard.image = self.backImage}
                        ) {_ in pCard.isUserInteractionEnabled = true}
                    }
                    
                    self.firstCard = nil

                    if self.matchCard >= 8 {self.resetGame()}
                } else {
                    self.firstCard = card
                }
            }
        }
    }
}

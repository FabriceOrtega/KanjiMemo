//
//  QuizzCardViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit
import Shuffle_iOS

class QuizzCardViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    // Instancoate the card stack
    let cardStack = SwipeCardStack()
    
    // List of activated kanji for the quizz
    var cardImages: [UIImage?] = []
    
    // Determine the card size
    var cardWidth: CGFloat {
        return UIScreen.main.bounds.width - 40
    }
    var cardHeight: CGFloat {
        return UIScreen.main.bounds.height - 320
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardStack)
        
        createCardStack()
        
        // Call the card stack
        cardStack.frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        
        cardStack.dataSource = self
        cardStack.delegate = self
    }
    
    // Swipe card method
    func card(fromImage image: UIImage) -> SwipeCard {
        // Instanciate the card
        let card = SwipeCard()
        // Accepted direction
        card.swipeDirections = [.left, .right]
        card.content = UIImageView(image: image)
        
//        let footer = card.footer
//        footer?.alpha = 1
//        footer?.backgroundColor = .blue
//        footer?.frame = CGRect(x: 0, y: -card.frame.height, width: card.frame.width, height: card.frame.height/2)
        
        // Attribute colors to cards when swipped
        let leftOverlay = UIView()
        leftOverlay.backgroundColor = .green
        
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = .red
        
        card.setOverlays([.left: leftOverlay, .right: rightOverlay])
        
        return card
    }
    
    
    // Stack creation method
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card(fromImage: cardImages[index]!)
    }
    
    // Stack count method
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        // Limit quizz to 25 Kanji
        if cardImages.count > 25 {
            return 25
        } else {
            return cardImages.count
        }
    }
    
    // Calling the build method from activated kanji list
    func createCardStack(){
        if CardCreator.cardCreator.listActivatedKAnji.count > 1 {
            cardImages = CardCreator.cardCreator.cardImages
        } else {
            alert(title: "Error", message: "Please select at least two Kanji to start the quizz")
        }
    }
    
    // Card swipe recognition
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(String(describing: CardCreator.cardCreator.listActivatedKAnji[index].kanji))")
    }
    
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

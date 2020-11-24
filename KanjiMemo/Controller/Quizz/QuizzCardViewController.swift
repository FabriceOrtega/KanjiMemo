//
//  QuizzCardViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit
import Shuffle_iOS

class QuizzCardViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    // Instanciate the Swipe card stack
    let cardStack = SwipeCardStack()
    
    // List of activated kanji for the quizz
    var cardImages: [UIImage?] = []
    
    // Calculate the card size
    var cardWidth: CGFloat {
        return UIScreen.main.bounds.width - 40
    }
    var cardHeight: CGFloat {
        return UIScreen.main.bounds.height - 320
    }
    
    // Set up a notification when card did swipe to the left
    static let notificationDidSwipeLeft = Notification.Name("didSwipeCardLeft")
    
    // Set up a notification when card did swipe to the left
    static let notificationDidSwipeRight = Notification.Name("didSwipeCardRight")
    
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
        
        // Attribute colors to cards when swipped
        let leftOverlay = UIView()
        leftOverlay.backgroundColor = .purple
        
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = .blue
        
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
        if cardImages.count > QuizzGame.quizzGame.maxCardQuizz {
            return QuizzGame.quizzGame.maxCardQuizz
        } else {
            return cardImages.count
        }
    }
    
    // Calling the build method from activated kanji list
    func createCardStack(){
        cardImages = CardCreator.cardCreator.cardImages
    }
    
    // Card swipe recognition
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {

        if direction == SwipeDirection.left {
            // Send notification that card swiped
            NotificationCenter.default.post(name: QuizzCardViewController.notificationDidSwipeLeft, object: nil, userInfo: ["index": index])
            
        } else if direction == SwipeDirection.right {
            // Send notification that card swiped
            NotificationCenter.default.post(name: QuizzCardViewController.notificationDidSwipeRight, object: nil, userInfo: ["index": index])
        }
    }
    
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

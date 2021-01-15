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
        return UIScreen.main.bounds.width
    }
    var cardHeight: CGFloat {
        return (UIScreen.main.bounds.height)/3
    }
    
    // Set up a notification when card did swipe to the up
    static let notificationDidSwipeUp = Notification.Name("didSwipeCardUp")
    
    // Set up a notification when card did swipe to the down
    static let notificationDidSwipeDown = Notification.Name("didSwipeCardDown")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardStack)
        view.bringSubviewToFront(cardStack)
        
        createCardStack()
        
        // Call the card stack
        cardStack.frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        
        cardStack.dataSource = self
        cardStack.delegate = self
    }
    
    // Swipe card method
    private func card(fromImage image: UIImage) -> SwipeCard {
        // Instanciate the card
        let card = SwipeCard()
        // Accepted direction
        card.swipeDirections = [.up, .down]
        card.content = UIImageView(image: image)
        
        // Attribute colors to cards when swipped
        let upOverlay = UIView()
        upOverlay.backgroundColor = #colorLiteral(red: 1, green: 0.7809510827, blue: 0.1670792401, alpha: 1)
        
        let downOverlay = UIView()
        downOverlay.backgroundColor = #colorLiteral(red: 0.7072762847, green: 0.8264989257, blue: 0.863738358, alpha: 1)
        
        card.setOverlays([.up: upOverlay, .down: downOverlay])
        
        return card
    }
    
    // Stack creation method
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        guard let cardToReturn = cardImages[index] else {return SwipeCard()}
        return card(fromImage: cardToReturn)
    }
    
    // Stack count method
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardImages.count
    }
    
    // Calling the build method from activated kanji list
    private func createCardStack(){
        cardImages = CardCreator.cardCreator.cardImages
    }
    
    // Card swipe recognition
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {

        if direction == SwipeDirection.up {
            // Send notification that card swiped
            NotificationCenter.default.post(name: QuizzCardViewController.notificationDidSwipeUp, object: nil, userInfo: ["index": index])
            
        } else if direction == SwipeDirection.down {
            // Send notification that card swiped
            NotificationCenter.default.post(name: QuizzCardViewController.notificationDidSwipeDown, object: nil, userInfo: ["index": index])
        }
    }
    
}

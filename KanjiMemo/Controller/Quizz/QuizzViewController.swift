//
//  QuizzViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit
import Shuffle_iOS

class QuizzViewController: UIViewController {
    
    // Translation text labels (one correct, one wrong)
    @IBOutlet weak var upText: UILabel!
    @IBOutlet weak var downText: UILabel!
    
    //Score label
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Number of cards in quizz label
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    
    // Right/Wrong images
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var wrongImageView: UIImageView!
    
    // Parameter to show the path to the QuizzCardViewController
    var quizzCardVC: QuizzCardViewController?
    
    // Parameter to show the path to the ShareVC
    var shareVC: ShareViewController?
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial texts to empty
        upText.text = ""
        downText.text = ""
        scoreLabel.text = ""
        
        // Observe the swipe of the card up
        NotificationCenter.default.addObserver(self, selector: #selector(cardDidSwipeUp(notification:)), name: QuizzCardViewController.notificationDidSwipeUp, object: nil)
        
        // Observe the swipe of the card down
        NotificationCenter.default.addObserver(self, selector: #selector(cardDidSwipeDown(notification:)), name: QuizzCardViewController.notificationDidSwipeDown, object: nil)
    }
    
    
    // unwid method used bu back button of the shareVC only for iOS<13
    @IBAction func unwindToQuizz(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizzCard" {
            DispatchQueue.main.async{
                self.quizzCardVC = segue.destination as? QuizzCardViewController
                self.attributeParamatersForSegueToQuizzCardVC()
            }
        } else if segue.identifier == "toShareView" {
            DispatchQueue.main.async{
                self.shareVC = segue.destination as? ShareViewController
                self.attributeParamatersForSegueToShareVC()
            }
        }
    }
    
    // Method to attribute the parameters to quizzcard
    private func attributeParamatersForSegueToQuizzCardVC(){
        //Placeholder to pass the parameters here
    }
    
    // Method to attribute the parameters to quizzcard
    private func attributeParamatersForSegueToShareVC(){
        //Placeholder to pass the parameters here
    }
    
    

    // Start quizz button
    @IBAction func startQuizz(_ sender: Any) {
        // User must select at least two cards to start the quizz
        if CardCreator.cardCreator.listActivatedKAnji.count > 1 {
            // Quizz starts
            QuizzGame.quizzGame.quizzIsOn = true
            
            // Create kanji cards
            CardCreator.cardCreator.createKanjiImages()
            
            // Generate the array of correct translation, wrong translation and position
            QuizzGame.quizzGame.generateArrays()
            // Set up the first one
            setUpText(index: 0)
            
            // Reinitialize the score
            QuizzGame.quizzGame.score = 0
            // Set the score
            setScoreLabel()
            
            // Call the QuizzCardVC view did laod to display the cards
            guard let quizzCardVC = self.quizzCardVC else {
                return
            }
            quizzCardVC.viewDidLoad()
            
        } else {
            alert(title: "Error", message: "Please select at least two Kanji to start the quizz !")
        }
    }
    
    
    private func setUpText(index: Int){
        
        if index < QuizzGame.quizzGame.numberCards {
            if QuizzGame.quizzGame.randomPositionArray[index] == 1 {
                upText.text = String(QuizzGame.quizzGame.correctTranslationArray[index])
                downText.text = String(QuizzGame.quizzGame.wrongTranslationArray[index])
            } else {
                upText.text = String(QuizzGame.quizzGame.wrongTranslationArray[index])
                downText.text = String(QuizzGame.quizzGame.correctTranslationArray[index])
            }
        } else {
            upText.text = ""
            downText.text = ""
            // Game is over
            QuizzGame.quizzGame.quizzIsOn = false
        }
    }
    
    // Method executed when the card swiped to the up
    @objc func cardDidSwipeUp(notification:Notification) {
        // Set next card
        setUpText(index: (notification.userInfo!["index"] as! Int)+1)
        
        // Call the quizz game method for up position (position 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: (notification.userInfo!["index"] as! Int), position: 1)
        
        // Animate the score if correctly answered
        animateScoreLabel(index: (notification.userInfo!["index"] as! Int), position: 1)
        
        // Refresh score
        setScoreLabel()
    }
    
    // Method executed when the card swiped to the down
    @objc func cardDidSwipeDown(notification:Notification) {
        // Set next card
        setUpText(index: (notification.userInfo!["index"] as! Int)+1)
        
        // Call the quizz game method  for down position (position 2)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: (notification.userInfo!["index"] as! Int), position: 2)
        
        // Animate the score if correctly answered
        animateScoreLabel(index: (notification.userInfo!["index"] as! Int), position: 2)
        
        // Refresh score
        setScoreLabel()
    }
    
    // Method to set the score label
    private func setScoreLabel(){
        if QuizzGame.quizzGame.score > 9 {
            scoreLabel.text = String(QuizzGame.quizzGame.score)
        } else {
            scoreLabel.text = "0" + String(QuizzGame.quizzGame.score)
        }
        
        if QuizzGame.quizzGame.numberCards > 9 {
            numberOfCardsLabel.text = String(QuizzGame.quizzGame.numberCards)
        } else {
            numberOfCardsLabel.text = "0" + String(QuizzGame.quizzGame.numberCards)
        }
        
        // 
        if !QuizzGame.quizzGame.quizzIsOn {
            performSegue(withIdentifier: "toShareView", sender: self)
        }
        
    }
    
    // Method to animate the score text label
    private func animateScoreLabel(index: Int, position: Int){
        // Check if question has been correctly answered
        if QuizzGame.quizzGame.randomPositionArray[index] == position {
            // Scale briefly the label and show the right image
            UIView.animate(withDuration: 0.5) {
                self.scoreLabel.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            }
            UIView.animate(withDuration: 0.5) {
                self.scoreLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            UIView.animate(withDuration: 2) {
                self.rightImageView.isHidden = false
                self.rightImageView.alpha = 1.0
            }
            UIView.animate(withDuration: 2) {
                self.rightImageView.alpha = 0.0
            }
        } else {
            // Show the briefly wrong image
            UIView.animate(withDuration: 2) {
                self.wrongImageView.isHidden = false
                self.wrongImageView.alpha = 1.0
            }
            UIView.animate(withDuration: 2) {
                self.wrongImageView.alpha = 0.0
            }
        }
    }

}

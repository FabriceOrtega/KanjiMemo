//
//  QuizzViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit
import Shuffle_iOS

class QuizzViewController: UIViewController {
    
    // Parameter for to show the path to the QuizzCardViewController
    var quizzCardVC: QuizzCardViewController!
    
    // Translation text labels (one correct, one wrong)
    @IBOutlet weak var leftText: UILabel!
    @IBOutlet weak var rightText: UILabel!
    
    //Score label
    @IBOutlet weak var scoreLabel: UILabel!
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial texts to empty
        leftText.text = ""
        rightText.text = ""
        scoreLabel.text = ""
        
        // Observe the swipe of the card left
        NotificationCenter.default.addObserver(self, selector: #selector(cardDidSwipeLeft(notification:)), name: QuizzCardViewController.notificationDidSwipeLeft, object: nil)
        
        // Observe the swipe of the card right
        NotificationCenter.default.addObserver(self, selector: #selector(cardDidSwipeRight(notification:)), name: QuizzCardViewController.notificationDidSwipeRight, object: nil)
    }
    
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizzCard" {
            DispatchQueue.main.async{
                self.quizzCardVC = segue.destination as? QuizzCardViewController
                self.attributeParamatersForSegue()
            }
        }
    }
    
    // Method to attribute the parameters to quizzcard
    func attributeParamatersForSegue(){
        //PASS the parameters here
    }
    

    // Start quizz button
    @IBAction func startQuizz(_ sender: Any) {
        
        if CardCreator.cardCreator.listActivatedKAnji.count > 1 {
            // Create kanji cards
            CardCreator.cardCreator.createKanjiImages()
            
            // Generate the array of correct translation, wrong translation and position
            QuizzGame.quizzGame.generateArrays()
            // Set up the first one
            setUpTestText(index: 0)
            
            // Reinitialize the score
            QuizzGame.quizzGame.score = 0
            // Set the score
            setScoreLabel()
            
            // Call the QuizzCardVC view did laod to display the cards
            self.quizzCardVC.viewDidLoad()
        } else {
            alert(title: "Error", message: "Please select at least two Kanji to start the quizz")
        }
        
        
    }
    

    
    func setUpTestText(index: Int){
        
        if index < CardCreator.cardCreator.listActivatedKAnji.count{
            if QuizzGame.quizzGame.randomPositionArray[index] == 1 {
                leftText.text = String(QuizzGame.quizzGame.correctTranslationArray[index])
                rightText.text = String(QuizzGame.quizzGame.wrongTranslationArray[index])
            } else {
                leftText.text = String(QuizzGame.quizzGame.wrongTranslationArray[index])
                rightText.text = String(QuizzGame.quizzGame.correctTranslationArray[index])
            }
        } else {
            leftText.text = ""
            rightText.text = ""
        }
    }
    
    // Method executed when the card swiped to the left
    @objc func cardDidSwipeLeft(notification:Notification) {
        // Set next card
        setUpTestText(index: (notification.userInfo!["index"] as! Int)+1)
        
        // Check if the quizz is correctly answered
        if QuizzGame.quizzGame.randomPositionArray[notification.userInfo!["index"] as! Int] == 1 {
            print("Correct")
            QuizzGame.quizzGame.score += 1
            animateScoreLabel()
        } else {
            print("Huuuuu")
        }
        
        // Refresh score
        setScoreLabel()
    }
    
    // Method executed when the card swiped to the right
    @objc func cardDidSwipeRight(notification:Notification) {
        // Set next card
        setUpTestText(index: (notification.userInfo!["index"] as! Int)+1)
        
        // Check if the quizz is correctly answered
        if QuizzGame.quizzGame.randomPositionArray[notification.userInfo!["index"] as! Int] == 2 {
            print("Correct")
            QuizzGame.quizzGame.score += 1
            animateScoreLabel()
        } else {
            print("Huuuuu")
        }
        
        // Refresh score
        setScoreLabel()
    }
    
    // Method to set the score label
    func setScoreLabel(){
        scoreLabel.text = "Score : " + String(QuizzGame.quizzGame.score) + " / " + String(QuizzGame.quizzGame.numberCards)
    }
    
    // Method to animate the score text label
    func animateScoreLabel(){
        // Scale briefly the label
        UIView.animate(withDuration: 0.5) {
            self.scoreLabel.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
        }
        UIView.animate(withDuration: 0.5) {
            self.scoreLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

}

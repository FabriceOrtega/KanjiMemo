//
//  StatsViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 27/11/2020.
//

import UIKit

class StatsViewController: UIViewController {
    
    // Label for number of kanji that appeared on the quizz
    @IBOutlet weak var numberKanjiUsed: UILabel!
    
    // Label for percentage of good answers
    @IBOutlet weak var percentageCorrectAnswer: UILabel!
    
    // Circle for percentage
    var roundView: UIView!
    
    // Calculate the circle radius
    var circleRadius: CGFloat {
        return UIScreen.main.bounds.width - 100
    }
    
    // Calculate the x position of the percentage circle
    var circleXPosition: CGFloat {
        return UIScreen.main.bounds.width/2 - (circleRadius/2)
    }
    
    // Calculate the y position of the percentage circle
    var circleYPosition: CGFloat {
        return UIScreen.main.bounds.height/2 - (circleRadius/2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title
        title = "Statistics"
        
        setLabels()
        Stats.stats.fillKanjiStatLists()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Set the labels
        setLabels()
        
        // Remove the previous percentage round
        roundView?.removeFromSuperview()
        
        // If no good answer stored, percentage is zero
        if Stats.stats.numberTotalGoodAnswer > 0 {
            // Draw circle
            roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: Stats.stats.percentageGoodAnswer, circleRadius: circleRadius, circleXPosition: circleXPosition, circleYPosition: circleYPosition, circleWidth: 12, animation: true)
            self.view.addSubview(roundView)
        } else {
            // Draw circle at O%
            roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: 0, circleRadius: circleRadius, circleXPosition: circleXPosition, circleYPosition: circleYPosition, circleWidth: 12, animation: true)
            
            self.view.addSubview(roundView)
        }
        
        // Send the circle to the back
        self.view.sendSubviewToBack(roundView)
    }
    
    // Buttonn to go to the list of stat details
    @IBAction func seeDetailsButton(_ sender: Any) {
        performSegue(withIdentifier: "toStatsDetails", sender: nil)
    }
    
    // Method to attribute the labels
    func setLabels() {
        // Set text that doesn't change
        let numberText = "Number of Kanji used : "
        
        // Set label of number kanji used
        numberKanjiUsed.text = numberText + String(Stats.stats.numberOfKanjiFromQuizz)
        
        // Set the percentage of correct answer label
        if Stats.stats.numberOfKanjiFromQuizz == 0 {
            percentageCorrectAnswer.text = "0 %"
        } else {
            // Set labels
            percentageCorrectAnswer.text = String(Stats.stats.percentageGoodAnswer) + " %"
        }
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatsDetails" {
            _ = segue.destination as! StatsTableViewController
        }
    }
    
}

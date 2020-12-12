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
    // Label of percentage of kanji used
    @IBOutlet weak var percentageKanjiUsed: UILabel!
    
    // Label for percentage of good answers
    @IBOutlet weak var percentageCorrectAnswer: UILabel!
    
    // Circle for percentage
    var roundView: UIView!
    
    // Calculate the circle radius
    var circleRadius: CGFloat {
        return UIScreen.main.bounds.width/2 - 60
    }
    
    // Calculate the x position of the percentage circle of correct answers
    var circleXPosition: CGFloat {
        return UIScreen.main.bounds.width/4 - (circleRadius/2)
    }
    
    // Calculate the x position of the percentage circle of kanji used
    var circleXPositionKanjiUsed: CGFloat {
        return UIScreen.main.bounds.width/4 * 3 - (circleRadius/2)
    }
    
    // Calculate the y position of the percentage circle
    var circleYPosition: CGFloat {
        return UIScreen.main.bounds.height/2 - (circleRadius/2) - 17
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        Stats.stats.fillKanjiStatLists()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Set the labels
        setLabels()
        
        // Remove the previous percentage round
        roundView?.removeFromSuperview()
        
        // Set the percentage circles
        setCorrectAnswersPercentageCircle()
        setKanjiUsedPercentageCircle()
    }
    
    // Buttonn to go to the list of stat details
    @IBAction func seeDetailsButton(_ sender: Any) {
        performSegue(withIdentifier: "toStatsDetails", sender: nil)
    }
    
    // Method to create and animate the good answer percentage circle
    func setCorrectAnswersPercentageCircle(){
        // If no good answer stored, percentage is zero
        if Stats.stats.numberTotalGoodAnswer > 0 {
            // Draw circle
            roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: Stats.stats.percentageGoodAnswer, circleRadius: circleRadius, circleXPosition: circleXPosition, circleYPosition: circleYPosition, circleWidth: 12, circleColor: #colorLiteral(red: 0.9996942878, green: 0.6558496356, blue: 0.1662026942, alpha: 1), backgroundColor: #colorLiteral(red: 0.9799283147, green: 0.7653592229, blue: 0.1608700454, alpha: 1), animation: true)
            self.view.addSubview(roundView)
        } else {
            // Draw circle at O%
            roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: 0, circleRadius: circleRadius, circleXPosition: circleXPosition, circleYPosition: circleYPosition, circleWidth: 12, circleColor: #colorLiteral(red: 0.9996942878, green: 0.6558496356, blue: 0.1662026942, alpha: 1), backgroundColor: #colorLiteral(red: 0.9799283147, green: 0.7653592229, blue: 0.1608700454, alpha: 1), animation: true)
            
            self.view.addSubview(roundView)
        }
    }
    
    // Method to create and animate the kanji used percentage circle
    func setKanjiUsedPercentageCircle(){
        // If no kanji used, percentage is zero
        if Stats.stats.numberOfKanjiFromQuizz > 0 {
            // Draw circle
            roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: Stats.stats.percentageKanjiUsed, circleRadius: circleRadius, circleXPosition: circleXPositionKanjiUsed, circleYPosition: circleYPosition, circleWidth: 12, circleColor: #colorLiteral(red: 0.639534235, green: 0.7437759042, blue: 0.7769008875, alpha: 1), backgroundColor: #colorLiteral(red: 0.7033440471, green: 0.822575748, blue: 0.8598157763, alpha: 1), animation: true)
            self.view.addSubview(roundView)
        } else {
            // Draw circle at O%
            roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: 0, circleRadius: circleRadius, circleXPosition: circleXPositionKanjiUsed, circleYPosition: circleYPosition, circleWidth: 12, circleColor: #colorLiteral(red: 0.639534235, green: 0.7437759042, blue: 0.7769008875, alpha: 1), backgroundColor: #colorLiteral(red: 0.7033440471, green: 0.822575748, blue: 0.8598157763, alpha: 1), animation: true)
            
            self.view.addSubview(roundView)
        }
    }
    
    // Method to attribute the labels
    func setLabels() {
        // Set label of number kanji used
        numberKanjiUsed.text = String(Stats.stats.numberOfKanjiFromQuizz)
        
        // Set the percentage of correct answer label
        if Stats.stats.numberOfKanjiFromQuizz == 0 {
            percentageCorrectAnswer.text = "0 %"
            percentageKanjiUsed.text = "0 %"
        } else {
            // Set labels
            percentageCorrectAnswer.text = String(Stats.stats.percentageGoodAnswer) + " %"
            percentageKanjiUsed.text = String(Stats.stats.percentageKanjiUsed) + " %"
        }
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatsDetails" {
            _ = segue.destination as! StatsTableViewController
        }
    }
    
}

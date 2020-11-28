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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Set the labels
        setLabels()
        
        // Remove the previous percentage round
        roundView?.removeFromSuperview()
        
        // If no good answer stored, percentage is zero
        if Stats.stats.numberTotalGoodAnswer > 0 {
            drawCircle(percentage: Stats.stats.percentageGoodAnswer)
        } else {
            drawCircle(percentage: 0)
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
    

    
    // Draw percentage circle
    func drawCircle(percentage: Int){
        roundView = UIView(frame:CGRect(x: circleXPosition, y: circleYPosition, width: circleRadius, height: circleRadius))
        
        roundView.backgroundColor = UIColor.red
        // Make the frame round
        roundView.layer.cornerRadius = roundView.frame.size.width / 2
        
        // Start of the arc corresponds to 12 0'clock
        let startAngle = -CGFloat.pi / 2
        // Proportion depending of percentage
        let proportion = CGFloat(percentage)
        let centre = CGPoint (x: roundView.frame.size.width / 2, y: roundView.frame.size.height / 2)
        let radius = roundView.frame.size.width / 2
        // The proportion of a full circle
        let arc = CGFloat.pi * 2 * proportion / 100
        
        // Start a mutable path
        let cPath = UIBezierPath()
        // Move to the centre
        cPath.move(to: centre)
        // Draw a line to the circumference
        cPath.addLine(to: CGPoint(x: centre.x + radius * cos(startAngle), y: centre.y + radius * sin(startAngle)))
        // NOW draw the arc
        cPath.addArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: arc + startAngle, clockwise: true)
        // Line back to the centre, where we started (or the stroke doesn't work, though the fill does)
        cPath.addLine(to: CGPoint(x: centre.x, y: centre.y))
        
        // circle shape
        let circleShape = CAShapeLayer()
        circleShape.path = cPath.cgPath
        circleShape.fillColor = UIColor.green.cgColor
        // add sublayer with transparency
        roundView.alpha = 0.5
        roundView.layer.addSublayer(circleShape)
        
        // White round
        let whiteRoundView = UIView(frame:CGRect(x: 12, y: 12, width: circleRadius-24, height: circleRadius-24))
        whiteRoundView.backgroundColor = UIColor.white
        whiteRoundView.layer.cornerRadius = whiteRoundView.frame.size.width / 2
        
        // add subview
        roundView.addSubview(whiteRoundView)
        self.view.addSubview(roundView)
    }
    
}

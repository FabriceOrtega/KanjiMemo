//
//  StatsTableViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 27/11/2020.
//

import UIKit

class StatsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var statsTableView: UITableView!
    
    // Extract the keys of the dictionary to create an array of Kanji
    var kanjiStatArray = Array(Stats.stats.countKanjiQuizz.keys)
    
    // Circle for percentage
    var roundView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        statsTableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Stats.stats.numberOfKanjiFromQuizz
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailStatsCell", for: indexPath) as? StatsTableViewCell
        
        let kanjiCurrentKey = kanjiStatArray[indexPath.row]
        
        cell?.kanjiLabel.text = kanjiStatArray[indexPath.row]
        
        cell?.appearnceLabel.text = "Appearance : \(Stats.stats.countKanjiQuizz[kanjiCurrentKey]!)"
        

        if Stats.stats.countKanjiCorrect[kanjiCurrentKey] == nil {
            // Set the correct answers to 0 and draw the circle at 0%
            cell?.correctLabel.text = "Correct : 0"
            drawCircle(percentage: 0, cell: cell)
        } else {
            // Calculate the percentage
            let percentageKanjiCell = Int(100 * Double(Stats.stats.countKanjiCorrect[kanjiCurrentKey]!) / Double(Stats.stats.countKanjiQuizz[kanjiCurrentKey]!))
            
            // Set the correct answers if more than 1
            cell?.correctLabel.text = "Correct : \(Stats.stats.countKanjiCorrect[kanjiCurrentKey]!)"
            
            // Draw the circle with the percentage in it
            drawCircle(percentage: percentageKanjiCell, cell: cell)
        }
        
        return cell!
    }
    
    // Draw percentage circle with percentage label
    func drawCircle(percentage: Int, cell: StatsTableViewCell?){
        // Calculate the circle radius
        var circleRadius: CGFloat {
            return (cell?.frame.height)!/2 + 10
        }
        
        // Calculate the x position of the percentage circle
        var circleXPosition: CGFloat {
            return (cell?.frame.width)! - (circleRadius) - 10
        }
        
        // Calculate the y position of the percentage circle
        var circleYPosition: CGFloat {
            return (cell?.frame.height)!/2 - (circleRadius/2)
        }
        
        // Define round frame
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
        roundView.alpha = 1
        roundView.layer.addSublayer(circleShape)
        
        // White round
        let whiteRoundView = UIView(frame:CGRect(x: 5, y: 5, width: circleRadius-10, height: circleRadius-10))
        whiteRoundView.backgroundColor = UIColor.white
        whiteRoundView.layer.cornerRadius = whiteRoundView.frame.size.width / 2
        
        // Percentage Label
        let percentLabel = CATextLayer()
        percentLabel.font = UIFont.systemFont(ofSize: 17)
        percentLabel.fontSize = 12
        percentLabel.frame = CGRect(x: 0, y: circleRadius/2 - percentLabel.fontSize/2, width: circleRadius, height: circleRadius)
        percentLabel.string = String(percentage) + " %"
        percentLabel.foregroundColor = UIColor.black.cgColor
        percentLabel.alignmentMode = CATextLayerAlignmentMode.center
        
        // add subview
        roundView.addSubview(whiteRoundView)
        roundView.layer.addSublayer(percentLabel)
        cell?.addSubview(roundView)
    }
}

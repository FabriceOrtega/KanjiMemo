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
    
    // To pass data to the detailled view
    var kanjiDetailData: Kanji?
    
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailStatsCell", for: indexPath) as? StatsTableViewCell else {
            return UITableViewCell()
            }
        
        let kanjiCurrentKey = kanjiStatArray[indexPath.row]
        
        cell.kanjiLabel.text = kanjiStatArray[indexPath.row]
        
        cell.appearnceLabel.text = "Appearance : \(Stats.stats.countKanjiQuizz[kanjiCurrentKey] ?? 0)"
        

        if let statCorrect = Stats.stats.countKanjiCorrect[kanjiCurrentKey] {
            // Calculate the percentage
            let percentageKanjiCell = Int(100 * Double(statCorrect) / Double(Stats.stats.countKanjiQuizz[kanjiCurrentKey] ?? 1))

            // Set the correct answers if more than 1
            cell.correctLabel.text = "Correct : \(statCorrect)"

            // Set the correct percentage
            cell.percentageLabel.text = String(percentageKanjiCell) + " %"

            // Draw the circle with the percentage in it
            drawCircle(percentage: percentageKanjiCell, cell: cell)
        } else {
            // Set the correct answers to 0 and draw the circle at 0%
            cell.correctLabel.text = "Correct : 0"
            drawCircle(percentage: 0, cell: cell)
        }
        
        
        return cell
    }
    
    //MARK: Draw percentage circle with percentage label
    private func drawCircle(percentage: Int, cell: StatsTableViewCell){
        // Calculate the circle radius
        var circleRadius: CGFloat {
            return cell.frame.height/2 + 10
        }
        
        // Calculate the x position of the percentage circle
        var circleXPosition: CGFloat {
            return cell.frame.width - (circleRadius) - 10
        }
        
        // Calculate the y position of the percentage circle
        var circleYPosition: CGFloat {
            return cell.frame.height/2 - (circleRadius/2)
        }
        
        // Call method from PercentageCircle class

        roundView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: percentage, circleRadius: circleRadius, circleXPosition: circleXPosition, circleYPosition: circleYPosition, circleWidth: 5, circleColor: #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), backgroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), animation: false)
        
        cell.addSubview(roundView)
    }
    
    // MARK: TableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // attribute the data
        let kanjiName = kanjiStatArray[indexPath.row]
        
        if let kanjiIndexToPass = Stats.stats.listOfAllKanji.firstIndex(where: { $0.kanji == kanjiName }) {
            
            let kanjiToPass = Stats.stats.listOfAllKanji[kanjiIndexToPass]
            
            kanjiDetailData = kanjiToPass
            
            performSegue(withIdentifier: "toKanjiDetailStats", sender: nil)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toKanjiDetailStats" {
            let detailVC = segue.destination as! KanjiDetailViewController
            detailVC.kanjiDetailData = kanjiDetailData
        }
    }
}

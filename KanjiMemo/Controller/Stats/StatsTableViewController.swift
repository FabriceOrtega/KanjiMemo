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
        // return the number of rows
        return kanjiStatArray.count
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
            let percentageKanjiCell = Int(100 * Double(statCorrect) / Double(Stats.stats.countKanjiQuizz[kanjiCurrentKey] ?? 0))

            // Set the correct answers if more than 1
            cell.correctLabel.text = "Correct : \(statCorrect)"

            // Set the correct percentage
            cell.percentageLabel.text = String(percentageKanjiCell) + " %"

            // Draw the circle with the percentage in it
            //drawCircle(percentage: percentageKanjiCell, cell: cell)
            cell.percentage = percentageKanjiCell
        } else {
            // Set the correct answers to 0 and draw the circle at 0%
            cell.correctLabel.text = "Correct : 0"
            cell.percentage = 0
        }
        
        
        return cell
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

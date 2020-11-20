//
//  KanjiDetailViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 15/11/2020.
//

import UIKit

class KanjiDetailViewController: UIViewController {
    
    // To get data from the TableViewController
    var kanjiDetailData: Kanji!
    
    // Labels
    @IBOutlet weak var kanjiLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var kunLabel: UILabel!
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the method to update labels
        attributeLables()
        
    }
    
    // Method to attribute the labels to the data passed thru the segway
    func attributeLables(){
        kanjiLabel.text = kanjiDetailData.kanji
        gradeLabel.text = "Grade " + String(kanjiDetailData.grade)
        
        //Build strings from array
        let englishString = kanjiDetailData.meanings.joined(separator:", ")
        let kunString = kanjiDetailData.kun_readings.joined(separator:", ")
        let onString = kanjiDetailData.on_readings.joined(separator:", ")
        let nameString = kanjiDetailData.name_readings.joined(separator:", ")
        
        //Attributes labels to strings
        englishLabel.text = englishString
        kunLabel.text = kunString
        onLabel.text = onString
        nameLabel.text = nameString
    }

}

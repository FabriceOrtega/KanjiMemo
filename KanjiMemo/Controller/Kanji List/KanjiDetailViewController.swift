//
//  KanjiDetailViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 15/11/2020.
//

import UIKit

class KanjiDetailViewController: UIViewController {
    
    // To get data from the TableViewController
    var kanjiDetailData: Kanji?
    
    // Labels
    @IBOutlet weak var kanjiLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var kunLabel: UILabel!
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Outlet for back button for iOS < 13 only
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show back button if iOS < 13
        showBackButton()
        
        // Call the method to update labels
        attributeLables()
        
    }
    
    // Method to attribute the labels to the data passed thru the segway
    func attributeLables(){
        kanjiLabel.text = kanjiDetailData?.kanji
        gradeLabel.text = "0" + String(kanjiDetailData?.grade ?? 1)
        
        //Build strings from array
        let englishString = kanjiDetailData?.meanings.joined(separator:", ")
        let kunString = kanjiDetailData?.kun_readings.joined(separator:", ")
        let onString = kanjiDetailData?.on_readings.joined(separator:", ")
        let nameString = kanjiDetailData?.name_readings.joined(separator:", ")
        
        //Attributes labels to strings
        englishLabel.text = englishString
        kunLabel.text = kunString
        onLabel.text = onString
        nameLabel.text = nameString
    }
    
    func showBackButton() {
        // Hide button id iOS 13 or more
        if #available(iOS 13, *) {
            backButtonOutlet.isHidden = true
        } else {
            backButtonOutlet.isHidden = false
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToKanjiTableVC", sender: self)
    }
    

}

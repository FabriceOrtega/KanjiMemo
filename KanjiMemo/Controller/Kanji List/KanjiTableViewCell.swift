//
//  KanjiTableViewCell.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 15/11/2020.
//

import UIKit

class KanjiTableViewCell: UITableViewCell {
    
    // Kanji outlet
    @IBOutlet weak var kanjiLabel: UILabel!
    
    // English traduction outlets
    @IBOutlet weak var englishLabel: UILabel!
    
    // Pronounciation outlets in hiragan/katakana
    @IBOutlet weak var kanaLabel: UILabel!
    
    //Switch
    @IBOutlet weak var kanjiSwitch: UISwitch!
    
    //For switch to be displayed with correct state in reusable cells
    override func prepareForReuse() {
        super.prepareForReuse()
        
        kanjiSwitch.isOn = false
     
    }
}



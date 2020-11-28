//
//  StatsTableViewCell.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 27/11/2020.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    
    // Labels of the cell
    @IBOutlet weak var kanjiLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var appearnceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

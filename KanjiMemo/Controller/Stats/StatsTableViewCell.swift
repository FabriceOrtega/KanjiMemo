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
    @IBOutlet weak var percentageLabel: UILabel!
    
    var percentage: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //For switch to be displayed with correct state in reusable cells
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Draw circle once in the cell
        drawCircle(percentage: percentage, cell: self)
     
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

        let roundView: UIView = PercentageCircle.percentageCircle.createPercentageCircle(percentage: percentage, circleRadius: circleRadius, circleXPosition: circleXPosition, circleYPosition: circleYPosition, circleWidth: 5, circleColor: #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), backgroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), animation: false)!
        
        cell.addSubview(roundView)
    }

}

//
//  ShareViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/12/2020.
//

import UIKit

class ShareViewController: UIViewController {
    
    // Score label
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Outlet of the view to share
    @IBOutlet weak var viewToShare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the score label
        setScoreLabel()
    }
    
    // Method to set the score label
    private func setScoreLabel() {
        if QuizzGame.quizzGame.score > 9 {
            scoreLabel.text = String(QuizzGame.quizzGame.score) + " / " + String(QuizzGame.quizzGame.numberCards)
        } else if QuizzGame.quizzGame.numberCards < 10 {
            scoreLabel.text = "0" + String(QuizzGame.quizzGame.score) + " / 0" + String(QuizzGame.quizzGame.numberCards)
        } else if QuizzGame.quizzGame.score < 10 && QuizzGame.quizzGame.numberCards > 9 {
            scoreLabel.text = "0" + String(QuizzGame.quizzGame.score) + " / " + String(QuizzGame.quizzGame.numberCards)
        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        share()
    }
    
    // Method to create the image and share it
    private func share(){
        // Create collage picture
        let size = viewToShare.frame.size
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let image = UIGraphicsGetImageFromCurrentImageContext(), let currentContext = UIGraphicsGetCurrentContext() else {return}
        viewToShare.layer.render(in: currentContext)
        
        UIGraphicsEndImageContext()
        
        // Share
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }


}

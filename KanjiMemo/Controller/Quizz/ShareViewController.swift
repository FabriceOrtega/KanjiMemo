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
    
    // Button for iOS <13
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide button if iOS13 or more
        showBackButton()
        
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
    
    // Back button because "present modally" is working starting iOS 13
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToQuizz", sender: self)
    }
    
    
    // Method to create the image and share it
    private func share(){
        // Create collage picture
        let size = viewToShare.frame.size
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        viewToShare.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return}
        
        UIGraphicsEndImageContext()
        
        // Share
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // Method to show the back button only if below iOS 13
    func showBackButton(){
        
        // Hide button id iOS 13 or more
        if #available(iOS 13, *) {
            backButtonOutlet.isHidden = true
        } else {
            backButtonOutlet.isHidden = false
        }
    }


}

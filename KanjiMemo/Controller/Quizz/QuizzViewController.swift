//
//  QuizzViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit
import Shuffle_iOS

class QuizzViewController: UIViewController {
    
    // Parameter for to show the path to the QuizzCardViewController
    var quizzCardVC: QuizzCardViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizzCard" {
            DispatchQueue.main.async{
                self.quizzCardVC = segue.destination as? QuizzCardViewController
                self.attributeParamatersForSegue()
            }
        }
    }
    
    // Method to attribute the parameters to quizzcard
    func attributeParamatersForSegue(){
        //PASS the parameters here
    }
    

    // Start quizz button
    @IBAction func startQuizz(_ sender: Any) {
        CardCreator.cardCreator.createKanjiImages()
        self.quizzCardVC.viewDidLoad()
    }
    

}

//
//  CardCreator.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit
import CoreData

public class CardCreator {
    
    // Pattern singleton
    public static let cardCreator = CardCreator()
    
    // List of kanji which switch is on (-> array to be saved with CoreData)
    var listActivatedKAnji: [Kanji] = []
    
    // Determine the card size
    var cardWidth: CGFloat {
        return UIScreen.main.bounds.width - 40
    }
    var cardHeight: CGFloat {
        return UIScreen.main.bounds.height - 320
    }
    
    // List of activated kanji for the quizz
    var cardImages: [UIImage?] = []
    
    // Public init for pattern singleton
    public init() {}
    
    //Method to create cards as UIImageView
    private func imageWith(kanji: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        let kanjiLabel = UILabel(frame: frame)
        kanjiLabel.textAlignment = .center
        kanjiLabel.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        kanjiLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        kanjiLabel.font = UIFont.boldSystemFont(ofSize: 200)
        kanjiLabel.text = kanji
        kanjiLabel.clipsToBounds = true
        kanjiLabel.layer.cornerRadius = 10
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            kanjiLabel.layer.render(in: currentContext)
            let kanjiImage = UIGraphicsGetImageFromCurrentImageContext()
            return kanjiImage
        }
        return nil
    }
    
    // Method to create images from kanji activated list
    public func createKanjiImages() {
//        print(listActivatedKAnji.count)
        
        // Randomize the array
        listActivatedKAnji.shuffle()
        
        // Empty image array before reuse
        cardImages.removeAll()
        
        // At least two kanji must be selected
        if listActivatedKAnji.count > 1 {
            
            // Loop in the array, and create a UIImage per kanji and it to the list with the max card limit
            if listActivatedKAnji.count > QuizzGame.quizzGame.maxCardQuizz {
                for i in 0...((QuizzGame.quizzGame.maxCardQuizz) - 1){
                    cardImages.append(imageWith(kanji: listActivatedKAnji[i].kanji))
                }
            } else {
                for i in 0...((listActivatedKAnji.count) - 1){
                    cardImages.append(imageWith(kanji: listActivatedKAnji[i].kanji))
                }
            }
        }
    }
    
}

//
//  CardCreator.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import UIKit

public class CardCreator {
    
    // Pattern singleton
    public static let cardCreator = CardCreator()
    
    // List of kanji which switch is on
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
    public init() {
        
    }
    
    //Method to create cards as UIImageView
    func imageWith(kanji: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        let kanjiLabel = UILabel(frame: frame)
        kanjiLabel.textAlignment = .center
        kanjiLabel.backgroundColor = .lightGray
        kanjiLabel.textColor = .white
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
//            print(listActivatedKAnji.count)
            
            // Loop in the array, and create a UIImage per kanji and it to the list
            for i in 0...((listActivatedKAnji.count) - 1){
                cardImages.append(imageWith(kanji: listActivatedKAnji[i].kanji))
            }
        }
    }
    
}

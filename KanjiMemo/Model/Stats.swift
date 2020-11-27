//
//  Stats.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 26/11/2020.
//

import Foundation

public class Stats{
    
    // Singleton pattern
    public static let stats = Stats()
    
    // Dictionary to store how many times the kanji have appeared in the quizz
    var countKanjiQuizz: [String:Int] = [:]
    
    // Dictionary to store how many times the kanji have been correctly answered
    var countKanjiCorrect: [String:Int] = [:]
    
    // Number of kanji appeared in the quizz
    var numberOfKanjiFromQuizz: Int {
        return countKanjiQuizz.count
    }
    
    // Number of total cards swipped
    var numberTotalCardSwipped: Int {
        var sum = 0
        for kanjiValue in countKanjiQuizz.values {
            sum += kanjiValue
        }
        return sum
    }
    
    // Number of total cards swipped
    var numberTotalGoodAnswer: Int {
        var sum = 0
        for kanjiValue in countKanjiCorrect.values {
            sum += kanjiValue
        }
        return sum
    }
    
    // Percentage of good answer
    var percentageGoodAnswer: Int {
        return Int(100 * (Double(numberTotalGoodAnswer) / Double(numberTotalCardSwipped)))
    }
    
    // Public init for pattern singleton
    public init() {
        
    }
    
    // Method the count of how many times the kanji was in the quizz
    func countKanji(index: Int){
        if index < CardCreator.cardCreator.listActivatedKAnji.count{
            // Check if kanji is already in the dictionary
            if countKanjiQuizz[CardCreator.cardCreator.listActivatedKAnji[index].kanji] == nil {
                // If not add it, with 1 as value
                countKanjiQuizz[CardCreator.cardCreator.listActivatedKAnji[index].kanji] = 1
            } else {
                // If yes, add +1 to the value
                countKanjiQuizz[CardCreator.cardCreator.listActivatedKAnji[index].kanji]! += 1
            }
        }
//        print(countKanjiQuizz)
//        print("Kanji in quizz : \(numberOfKanjiFromQuizz)")
//        print("Total card swipped : \(numberTotalCardSwipped)")
    }
    
    // Method the count of how many times the kanji has been correctly answered
    func countCorrectAnswer(index: Int){
        if index < CardCreator.cardCreator.listActivatedKAnji.count{
            // Check if kanji is already in the dictionary
            if countKanjiCorrect[CardCreator.cardCreator.listActivatedKAnji[index].kanji] == nil {
                // If not add it, with 1 as value
                countKanjiCorrect[CardCreator.cardCreator.listActivatedKAnji[index].kanji] = 1
            } else {
                // If yes, add +1 to the value
                countKanjiCorrect[CardCreator.cardCreator.listActivatedKAnji[index].kanji]! += 1
            }
        }
//        print(countKanjiCorrect)
//        print("Total good answer : \(numberTotalGoodAnswer)")
        print("Percentage of correct answer : \(percentageGoodAnswer) %")
    }
    
    
}

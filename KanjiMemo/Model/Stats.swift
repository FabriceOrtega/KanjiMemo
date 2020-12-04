//
//  Stats.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 26/11/2020.
//

import Foundation
import CoreData

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
    public init() {}
    
    // Method the count of how many times the kanji was in the quizz
    func countKanji(index: Int){
        if index < CardCreator.cardCreator.listActivatedKAnji.count{
            // Check if kanji is already in the dictionary
            if countKanjiQuizz[CardCreator.cardCreator.listActivatedKAnji[index].kanji] == nil {
                // If not add it, with 1 as value
                countKanjiQuizz[CardCreator.cardCreator.listActivatedKAnji[index].kanji] = 1
                // Create entity
                saveAppearanceCounting(index: index)
            } else {
                // If yes, add +1 to the value
                countKanjiQuizz[CardCreator.cardCreator.listActivatedKAnji[index].kanji]! += 1
                // Save entity with +1 as appearance
                saveAppearanceCounting(index: index)
            }
        }
    }
    
    // Method the count of how many times the kanji has been correctly answered
    func countCorrectAnswer(index: Int){
        if index < CardCreator.cardCreator.listActivatedKAnji.count{
            // Check if kanji is already in the dictionary
            if countKanjiCorrect[CardCreator.cardCreator.listActivatedKAnji[index].kanji] == nil {
                // If not add it, with 1 as value
                countKanjiCorrect[CardCreator.cardCreator.listActivatedKAnji[index].kanji] = 1
                // Save entity with 1 as correct
                saveCorrectCounting(index: index)
            } else {
                // If yes, add +1 to the value
                countKanjiCorrect[CardCreator.cardCreator.listActivatedKAnji[index].kanji]! += 1
                // Save entity with +1 as correct
                saveCorrectCounting(index: index)
            }
        }
        //        print(countKanjiCorrect)
        //        print("Total good answer : \(numberTotalGoodAnswer)")
        print("Percentage of correct answer : \(percentageGoodAnswer) %")
    }
    
    
    // MARK: Database Methods
    
    // Method to add an kanji in the database
    private func saveAppearanceCounting (index: Int) {
        // Check if entity is already existing with the kanji string
        if StatsEntity.all.contains(where: { $0.kanji == CardCreator.cardCreator.listActivatedKAnji[index].kanji }){
            // Do +1 in appearance and save
            print("add one to existing")
            
            let request: NSFetchRequest<StatsEntity> = StatsEntity.fetchRequest()
            if let statistics = try? AppDelegate.viewContext.fetch(request){
                for i in statistics {
                    if i.kanji == CardCreator.cardCreator.listActivatedKAnji[index].kanji {
                        i.appearance += 1
                    }
                }
            }
            
            // Save the context
            try? AppDelegate.viewContext.save()
            
        } else {
            // Create entity and save
            print("create new entity")
            
            let stat = StatsEntity(context: AppDelegate.viewContext)
            stat.kanji = CardCreator.cardCreator.listActivatedKAnji[index].kanji
            stat.appearance = 1
            // Save the context
            try? AppDelegate.viewContext.save()
            
        }
        
    }
    
    // Method to add an kanji in the database
    private func saveCorrectCounting (index: Int) {
        // Check if entity is already existing with the kanji string
        if StatsEntity.all.contains(where: { $0.kanji == CardCreator.cardCreator.listActivatedKAnji[index].kanji }){
            // Do +1 in appearance and save
            print("add one to existing")
            
            let request: NSFetchRequest<StatsEntity> = StatsEntity.fetchRequest()
            if let statistics = try? AppDelegate.viewContext.fetch(request){
                for i in statistics {
                    if i.kanji == CardCreator.cardCreator.listActivatedKAnji[index].kanji {
                        i.correct += 1
                    }
                }
            }
            
            // Save the context
            try? AppDelegate.viewContext.save()
            
        } else {
            // Create entity and save
            print("Entity not existing, cannot save the correct stat")
        }
        
    }
    
    // Method to charge data from database for both libraries
    func fillKanjiStatLists() {
        fillCountKanjiQuizz()
        fillCountKanjiCorrect()
    }
    
    // Method to charge data from database
    private func fillCountKanjiQuizz() {
        print("StatsEntity.all.count = ")
        for i in StatsEntity.all {
            if i.kanji != nil {
                print(i.kanji!)
                print(i.appearance)
                // Check if kanji is already in library
                countKanjiQuizz[i.kanji!] = Int(i.appearance)
            }
        }
    }
    
    // Method to charge data from database
    private func fillCountKanjiCorrect() {
        print("StatsEntity.all.count = ")
        for i in StatsEntity.all {
            if i.kanji != nil {
                print(i.kanji!)
                print(i.correct)
                // Check if kanji is already in library
                countKanjiCorrect[i.kanji!] = Int(i.correct)
            }
        }
    }
    
}

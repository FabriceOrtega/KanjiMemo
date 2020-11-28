//
//  QuizzGame.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 19/11/2020.
//

import Foundation

public class QuizzGame {
    
    // Pattern singleton
    public static let quizzGame = QuizzGame()
    
    // Correct translation
    var correctTranslationArray: [String] = []
    
    // Wrong translation
    var wrongTranslationArray: [String] = []
    
    // Random number to attribute wrong translation
    var randomWrongTranslation: Int!
    
    // Random number to attribute position to correct translation (1:left, 2:Right)
    var randomPositionArray: [Int] = []
    
    // Number of maximum cards in the quizz
    var maxCardQuizz = 25
    
    // Number of cards in the quizz (max is limited)
    var numberCards: Int {
        if CardCreator.cardCreator.listActivatedKAnji.count > maxCardQuizz {
            return maxCardQuizz
        } else {
            return CardCreator.cardCreator.listActivatedKAnji.count
        }
    }
    
    // Score
    var score = 0
    
    // Boolean to check if quizz is currenlty on going
    var quizzIsOn = false
    
    // Public init for pattern singleton
    public init() {}
    
    // Generate all arrays
    func generateArrays(){
        generateCorrectTranslationArray()
        generateRandomWrongArray()
        generateRandomPositionArray()
    }
    
    func generateCorrectTranslationArray(){
        // Empty the array
        correctTranslationArray = []
        
        for index in 0...CardCreator.cardCreator.listActivatedKAnji.count-1 {
            let englishTranslation =  CardCreator.cardCreator.listActivatedKAnji[index].meanings.joined(separator:", ")
            correctTranslationArray.append(englishTranslation)
        }
        print("Correct : \(correctTranslationArray)")
    }
    
    // Method to generate wrong translation
    func generateRandomWrongArray(){
        // Empty the array
        wrongTranslationArray = []
        
        for index in 0...CardCreator.cardCreator.listActivatedKAnji.count-1 {
            // Generate a ramdom number
            randomWrongTranslation = Int.random(in: 0...CardCreator.cardCreator.listActivatedKAnji.count-1)
            
            // If generated number is same as index, generate again until it is not
            while randomWrongTranslation == index {
                print("same, need to regenerate")
                randomWrongTranslation = Int.random(in: 0...CardCreator.cardCreator.listActivatedKAnji.count-1)
            }
            
            // Build the tanslation from the array
            let englishWrongTranslation =  CardCreator.cardCreator.listActivatedKAnji[randomWrongTranslation].meanings.joined(separator:", ")
            
            wrongTranslationArray.append(englishWrongTranslation)
        }
        print("Wrong : \(wrongTranslationArray)")
    }
    
    // Method to generate random number for correct translation
    func generateRandomPositionArray(){
        // Empty the array
        randomPositionArray = []
        
        for _ in 0...CardCreator.cardCreator.listActivatedKAnji.count-1 {
            let randomPositionForCard = Int.random(in: 1...2)
            randomPositionArray.append(randomPositionForCard)
        }
        print(randomPositionArray)
    }
    
    // Method to check is correct translation is chosen
    func checkIfCorrectTranslation(index: Int, position: Int){
        if randomPositionArray[index] == position {
            print("Correct")
            score += 1
            Stats.stats.countKanji(index: index)
            Stats.stats.countCorrectAnswer(index: index)
        } else {
            print("Wrong!!")
            Stats.stats.countKanji(index: index)
        }
    }
   
}

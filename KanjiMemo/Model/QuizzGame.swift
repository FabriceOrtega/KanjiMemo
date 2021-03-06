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
    
    // Random number to attribute position to correct translation (1:up, 2:down)
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
    
    private func generateCorrectTranslationArray(){
        // Empty the array
        correctTranslationArray = []
        
        for index in 0...numberCards-1 {
            let englishTranslation =  CardCreator.cardCreator.listActivatedKAnji[index].meanings.joined(separator:", ")
            correctTranslationArray.append(englishTranslation)
        }
    }
    
    // Method to generate wrong translation
    private func generateRandomWrongArray(){
        // Empty the array
        wrongTranslationArray = []
        
        for index in 0...numberCards-1 {
            // Generate a ramdom number
            randomWrongTranslation = Int.random(in: 0...CardCreator.cardCreator.listActivatedKAnji.count-1)
            
            // If generated number is same as index, generate again until it is not
            while randomWrongTranslation == index {
                randomWrongTranslation = Int.random(in: 0...CardCreator.cardCreator.listActivatedKAnji.count-1)
            }
            
            // Build the tanslation from the array
            let englishWrongTranslation =  CardCreator.cardCreator.listActivatedKAnji[randomWrongTranslation].meanings.joined(separator:", ")
            
            wrongTranslationArray.append(englishWrongTranslation)
        }
    }
    
    // Method to generate random number for correct translation
    private func generateRandomPositionArray(){
        // Empty the array
        randomPositionArray = []
        
        for _ in 0...numberCards-1 {
            let randomPositionForCard = Int.random(in: 1...2)
            randomPositionArray.append(randomPositionForCard)
        }
    }
    
    // Method to check is correct translation is chosen
    func checkIfCorrectTranslation(index: Int, position: Int){
        if randomPositionArray[index] == position {
            score += 1
            Stats.stats.countKanji(index: index)
            Stats.stats.countCorrectAnswer(index: index)
        } else {
            Stats.stats.countKanji(index: index)
        }
    }
   
}

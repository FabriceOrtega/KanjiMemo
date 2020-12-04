//
//  QuizzGameTestCase.swift
//  KanjiMemoTests
//
//  Created by Fabrice Ortega on 03/12/2020.
//

import XCTest
@testable import KanjiMemo

class QuizzGameTestCase: XCTestCase {
    
    // Test if the number of generated array is correct
    func testGivenActivatedKanjiIsThreeWhenWeGeneratesArrayThenEachArrayShouldHaveThreeElement(){
        // The list of activated Kanji contain 3 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Generate the arrays (correct translation, wrong translation and position)
        QuizzGame.quizzGame.generateArrays()
        
        // Chack the number of elementes
        XCTAssert(CardCreator.cardCreator.listActivatedKAnji.count == QuizzGame.quizzGame.correctTranslationArray.count)
        XCTAssert(CardCreator.cardCreator.listActivatedKAnji.count == QuizzGame.quizzGame.wrongTranslationArray.count)
        XCTAssert(CardCreator.cardCreator.listActivatedKAnji.count == QuizzGame.quizzGame.randomPositionArray.count)
    }
    
    // Test if the number of generated array is correctc with maxcard<list
    func testGivenActivatedKanjiIsThreeAndMaxCardIsTwoWhenWeGeneratesArrayThenEachArrayShouldHaveThreeElement(){
        // The list of activated Kanji contain 3 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 2
        // Generate the arrays (correct translation, wrong translation and position)
        QuizzGame.quizzGame.generateArrays()
        
        // Chack the number of elementes
        XCTAssert(QuizzGame.quizzGame.correctTranslationArray.count == QuizzGame.quizzGame.maxCardQuizz)
        XCTAssert(QuizzGame.quizzGame.wrongTranslationArray.count == QuizzGame.quizzGame.maxCardQuizz)
        XCTAssert(QuizzGame.quizzGame.randomPositionArray.count == QuizzGame.quizzGame.maxCardQuizz)
    }
    
    // Test if correct translation is the correct one
    func testGivenActivatedKanjiIsThreeWhenWeGeneratesArrayThenCorrectTranslationShouldBeCorrect(){
        // The list of activated Kanji contain 3 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Generate the arrays (correct translation, wrong translation and position)
        QuizzGame.quizzGame.generateArrays()
        
        // Chack the number of elementes
        XCTAssert(QuizzGame.quizzGame.correctTranslationArray[0] == CardCreator.cardCreator.listActivatedKAnji[0].meanings.joined(separator:", "))
        XCTAssert(QuizzGame.quizzGame.correctTranslationArray[1] == CardCreator.cardCreator.listActivatedKAnji[1].meanings.joined(separator:", "))
        XCTAssert(QuizzGame.quizzGame.correctTranslationArray[2] == CardCreator.cardCreator.listActivatedKAnji[2].meanings.joined(separator:", "))
    }
    
    // Test if wrong translation is not the correct one
    func testGivenActivatedKanjiIsThreeWhenWeGeneratesArrayThenWrongTranslationShouldNotBeCorrect(){
        // The list of activated Kanji contain 3 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Generate the arrays (correct translation, wrong translation and position)
        QuizzGame.quizzGame.generateArrays()
        
        // Chack the number of elementes
        XCTAssert(QuizzGame.quizzGame.wrongTranslationArray[0] != CardCreator.cardCreator.listActivatedKAnji[0].meanings.joined(separator:", "))
        XCTAssert(QuizzGame.quizzGame.wrongTranslationArray[1] != CardCreator.cardCreator.listActivatedKAnji[1].meanings.joined(separator:", "))
        XCTAssert(QuizzGame.quizzGame.wrongTranslationArray[2] != CardCreator.cardCreator.listActivatedKAnji[2].meanings.joined(separator:", "))
    }
    
    // Check if point increment by 1 if answer is correct
    func testGivenScoreIsZeroWhenAnsweringCorrectlyThenScoreShouldBeOne(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        // Score is 0
        QuizzGame.quizzGame.score = 0
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Force the random position array for the the test
        QuizzGame.quizzGame.randomPositionArray = [1, 1, 1]
        // Answer correctly
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        
        // Check if score is One
        XCTAssert(QuizzGame.quizzGame.score == 1)
    }
    
    // Check if point stay at zero if answer is wrong
    func testGivenScoreIsZeroWhenAnsweringWronglyThenScoreShouldStayZero(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        // Score is 0
        QuizzGame.quizzGame.score = 0
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Force the random position array for the the test
        QuizzGame.quizzGame.randomPositionArray = [0, 0, 0]
        // Answer wronlly
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        
        // Check if score is One
        XCTAssert(QuizzGame.quizzGame.score == 0)
    }
}

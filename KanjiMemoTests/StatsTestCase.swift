//
//  StatsTestCase.swift
//  KanjiMemoTests
//
//  Created by Fabrice Ortega on 03/12/2020.
//

import XCTest
@testable import KanjiMemo

class StatsTestCase: XCTestCase {
    // Check if appearance is one when appeared in quizz for first time
    func testGivenAppeanceArrayIsEmptyWhenAnsweringQuizzThenAppearnaceArrayShouldGetOneForTheAnsweredKanji(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        //Initlize the the counting library
        Stats.stats.countKanjiQuizz = [:]
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Answer all (as the array is shuffled)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 1, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 2, position: 1)
        
        
        // Check if score is One
        XCTAssert(Stats.stats.countKanjiQuizz["一"] == 1)
        XCTAssert(Stats.stats.countKanjiQuizz["右"] == 1)
        XCTAssert(Stats.stats.countKanjiQuizz["雨"] == 1)
    }
    
    // Check if appearance is two when appeared in quizz for second time
    func testGivenAppeanceArrayIsOneWhenAnsweringQuizzThenAppearnaceArrayShouldGetTwoForTheAnsweredKanji(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]

        
        //Initlize the the counting library
        Stats.stats.countKanjiQuizz = ["一":1, "右":1, "雨":1]
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Answer all (as the array is shuffled)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 1, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 2, position: 1)
        
        
        // Check if score is One
        XCTAssert(Stats.stats.countKanjiQuizz["一"] == 2)
        XCTAssert(Stats.stats.countKanjiQuizz["右"] == 2)
        XCTAssert(Stats.stats.countKanjiQuizz["雨"] == 2)
    }
    
    // Check if correct counting is one when correctly answered in quizz for first time
    func testGivenCorrectArrayIsEmptyWhenCorrectlyAnsweringQuizzThenCorrectArrayShouldGetOneForTheAnsweredKanji(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        //Initlize the the counting library
        Stats.stats.countKanjiCorrect = [:]
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Force the random position array for the the test
        QuizzGame.quizzGame.randomPositionArray = [1, 1, 1]
        // Answer all (as the array is shuffled)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 1, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 2, position: 1)
        
        
        // Check if score is One
        XCTAssert(Stats.stats.countKanjiCorrect["一"] == 1)
        XCTAssert(Stats.stats.countKanjiCorrect["右"] == 1)
        XCTAssert(Stats.stats.countKanjiCorrect["雨"] == 1)
    }
    
    // Check if correct counting is two when correctly answered in quizz for second time
    func testGivenCorrectArrayIsOneWhenCorrectlyAnsweringQuizzThenCorrectArrayShouldGetTwoForTheAnsweredKanji(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        //Initlize the the counting library
        Stats.stats.countKanjiCorrect = ["一":1, "右":1, "雨":1]
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Force the random position array for the the test
        QuizzGame.quizzGame.randomPositionArray = [1, 1, 1]
        // Answer all (as the array is shuffled)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 1, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 2, position: 1)
        
        
        // Check if score is One
        XCTAssert(Stats.stats.countKanjiCorrect["一"] == 2)
        XCTAssert(Stats.stats.countKanjiCorrect["右"] == 2)
        XCTAssert(Stats.stats.countKanjiCorrect["雨"] == 2)
    }
    
    // Check if correct counting library stays empty when wronly answered in quizz for first time
    func testGivenCorrectArrayIsEmptyWhenWronglyAnsweringQuizzThenCorrectArrayShouldRemainEmpty(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        //Initlize the the counting library
        Stats.stats.countKanjiCorrect = [:]
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Force the random position array for the the test
        QuizzGame.quizzGame.randomPositionArray = [0, 0, 0]
        // Answer all (as the array is shuffled)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 1, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 2, position: 1)
        
        
        // Check if score is One
        XCTAssert(Stats.stats.countKanjiCorrect == [:])
    }
    
    // Check if correct counting library stays with One when wronly answered in quizz for second the kanji appears
    func testGivenCorrectArrayIsOneWhenWronglyAnsweringQuizzThenCorrectArrayShouldRemainOne(){
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        //Initlize the the counting library
        Stats.stats.countKanjiCorrect = ["一":1, "右":1, "雨":1]
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        // Create the cards
        CardCreator.cardCreator.createKanjiImages()
        // Generate the arrays
        QuizzGame.quizzGame.generateArrays()
        // Force the random position array for the the test
        QuizzGame.quizzGame.randomPositionArray = [0, 0, 0]
        // Answer all (as the array is shuffled)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 0, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 1, position: 1)
        QuizzGame.quizzGame.checkIfCorrectTranslation(index: 2, position: 1)
        
        
        // Check if score is One
        XCTAssert(Stats.stats.countKanjiCorrect["一"] == 1)
        XCTAssert(Stats.stats.countKanjiCorrect["右"] == 1)
        XCTAssert(Stats.stats.countKanjiCorrect["雨"] == 1)
    }
    
}

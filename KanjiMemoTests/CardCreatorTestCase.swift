//
//  CardCreatorTestCase.swift
//  KanjiMemoTests
//
//  Created by Fabrice Ortega on 03/12/2020.
//

import XCTest
@testable import KanjiMemo

class CardCreatorTestCase: XCTestCase {
    // Test when list of activated kanji is empty
    func testGivenListSelectedKanjiIsEmptyWhenCreatingTheCardsThenNoCardsAreCreated(){
        // Empty the list of activated Kanji
        CardCreator.cardCreator.listActivatedKAnji = []
        
        // Call the method to create the cards
        CardCreator.cardCreator.createKanjiImages()
        
        // Check the number of cards
        XCTAssert(CardCreator.cardCreator.cardImages.count == 0)
    }
    
    // Test when list of activated kanji has 1 (at least two to create cards)
    func testGivenListSelectedKanjiIsOneWhenCreatingTheCardsThenNoCardsAreCreated(){
        // The list of activated Kanji contain 1 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one")]
        
        // Call the method to create the cards
        CardCreator.cardCreator.createKanjiImages()
        
        // Check the number of cards
        XCTAssert(CardCreator.cardCreator.cardImages.count == 0)
    }
    
    // Test when list of activated kanji has 3, max card allowed is 2
    func testGivenListSelectedKanjiIsThreeAndMawIsTwoWhenCreatingTheCardsThenThreeCardsAreCreated(){
        // The list of activated Kanji contain 1 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 2
        
        // Call the method to create the cards
        CardCreator.cardCreator.createKanjiImages()
        
        // Check the number of cards
        XCTAssert(CardCreator.cardCreator.cardImages.count == 2)
    }
    
    // Test when list of activated kanji has 3
    func testGivenListSelectedKanjiIsThreeWhenCreatingTheCardsThenThreeCardsAreCreated(){
        // The list of activated Kanji contain 3 kanji
        CardCreator.cardCreator.listActivatedKAnji = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")]
        
        // Maximum cards allowed is two
        QuizzGame.quizzGame.maxCardQuizz = 25
        
        // Call the method to create the cards
        CardCreator.cardCreator.createKanjiImages()
        
        // Check the number of cards
        XCTAssert(CardCreator.cardCreator.cardImages.count == 3)
    }
    
}

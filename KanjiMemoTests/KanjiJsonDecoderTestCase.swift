//
//  KanjiJsonDecoderTestCase.swift
//  KanjiMemoTests
//
//  Created by Fabrice Ortega on 03/12/2020.
//

import XCTest
@testable import KanjiMemo

class KanjiJsonDecoderTestCase: XCTestCase {
    
    func testDecodeKanjiJsonShouldPostAnErrorifError(){
        let myAPI = KanjiJsonDecoder(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.decodeKanjiJson { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let kanji):
                XCTAssertNil(kanji)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDecodeKanjiJsonShouldPostAnErrorifNoData(){
        let myAPI = KanjiJsonDecoder(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.decodeKanjiJson { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let kanji):
                XCTAssertNil(kanji)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDecodeKanjiJsonShouldPostAnErrorifIncorrectResponse(){
        let myAPI = KanjiJsonDecoder(session: URLSessionFake(data: FakeResponseData.APICorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.decodeKanjiJson { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let kanji):
                XCTAssertNotNil(kanji)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDecodeKanjiJsonShouldNotPostAnErrorifCorrectResponse(){
        let myAPI = KanjiJsonDecoder(session: URLSessionFake(data: FakeResponseData.APICorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.decodeKanjiJson { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let kanji):
                XCTAssertNotNil(kanji)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDecodeKanjiJsonShouldPostAnErrorifIncorrectData(){
        let myAPI = KanjiJsonDecoder(session: URLSessionFake(data: FakeResponseData.APIIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.decodeKanjiJson { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let kanji):
                XCTAssertNotNil(kanji)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDecodeKanjiJsonShouldBeSuccessfullWhenAllIsCorrect(){
        let myAPI = KanjiJsonDecoder(session: URLSessionFake(data: FakeResponseData.APICorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // Build the expected result
        let kanjiList = [KanjiMemo.Kanji(kanji: "一", grade: 1, stroke_count: 1, meanings: ["one", "one radical (no.1)"], kun_readings: ["ひと-", "ひと.つ"], on_readings: ["イチ","イツ"], name_readings: ["かず", "い", "いっ", "いる", "かつ", "かづ", "てん", "はじめ", "ひ", "ひとつ", "まこと"], jlpt: 4, unicode: "4e00", heisig_en: "one"),
            KanjiMemo.Kanji(kanji: "右" ,grade: 1, stroke_count: 5, meanings: ["right"], kun_readings: ["みぎ"], on_readings: ["ウ","ユウ"], name_readings: ["あき","すけ"], jlpt: 4, unicode: "53f3", heisig_en: "right"),
            KanjiMemo.Kanji(kanji: "雨", grade: 1, stroke_count: 8, meanings: ["rain"], kun_readings: ["あめ", "あま-", "-さめ"], on_readings: ["ウ"], name_readings: [], jlpt: 4, unicode: "96e8", heisig_en: "rain")
        ]
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.decodeKanjiJson{ result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let kanji):
                XCTAssertNotNil(kanji)
                XCTAssertEqual(kanji, kanjiList)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}

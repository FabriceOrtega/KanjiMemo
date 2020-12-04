//
//  FakeResponseData.swift
//  KanjiMemoTests
//
//  Created by Fabrice Ortega on 03/12/2020.
//

import Foundation

class FakeResponseData {
    // Simulate answers
    static let responseOK = HTTPURLResponse(url: URL(string: "https://my.api.mockaroo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://my.api.mockaroo.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // Simulate error
    class APIError: Error{}
    static let error = APIError()
    
    //go to the correct datas
    static var APICorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "KanjiTest", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //Simule des datas endomagés
    static let APIIncorrectData = "erreur".data(using: .utf8)!
    
}

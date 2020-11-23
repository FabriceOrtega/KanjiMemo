//
//  KanjiJsonDecoder.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 14/11/2020.
//

import Foundation

struct KanjiJsonDecoder {
    // Kanji.json file
    let url = URL(fileURLWithPath: Bundle.main.path(forResource: "Kanji", ofType: "json")!)
    var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    func decodeKanjiJson(completion: @escaping(Result<[Kanji], UserError>) -> Void) {
        // Create the task
        let dataTask = session.dataTask(with: url) {data, response, error in
            // check if data is available
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            // If data available, convert it thru the decoder
            do {
                let decoder = JSONDecoder()
                let kanjiResponse = try decoder.decode([Kanji].self, from: jsonData)

                completion(.success(kanjiResponse))
                
                // If not ptossible to decode
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}

// Enumeration in order to be get more precise errprs
enum UserError: Error {
    case noDataAvailable
    case canNotProcessData
}



//
//  Kanji.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 14/11/2020.
//

import Foundation
import CoreData

public class Kanji: NSObject, Decodable {
    // Parameters from json
    var kanji: String!
    var grade: Int!
    var stroke_count: Int!
    var meanings: [String]!
    var kun_readings: [String]!
    var on_readings: [String]!
    var name_readings: [String]!
    var jlpt: Int!
    var unicode: String!
    var heisig_en: String!
}

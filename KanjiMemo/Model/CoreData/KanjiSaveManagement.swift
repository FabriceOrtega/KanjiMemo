//
//  KanjiSaveManagement.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 29/11/2020.
//

import Foundation
import CoreData

class KanjiSaveManagement {
    
    // Singleton pattern
    public static let kanjiSaveManagement = KanjiSaveManagement()
    
    // Public init for pattern singleton
    public init() {}
    
    // MARK: Database Methods
    
    // Method to add an kanji in the database
    func saveKanji(kanjiName: String) {
        // Save the object in the context
        let kanji = KanjiEntity(context: AppDelegate.viewContext)
        kanji.kanji = kanjiName
        
        // Save the context
        try? AppDelegate.viewContext.save()
    }
    
    // Method to remove a kanji from the database
    func removeKanji(kanjiName: String) {
        // Save the object in the context
        let request: NSFetchRequest<KanjiEntity> = KanjiEntity.fetchRequest()
        if let kanjis = try? AppDelegate.viewContext.fetch(request){
            for i in kanjis {
                if i.kanji == kanjiName {
                    AppDelegate.viewContext.delete(i)
                }
            }
        }
        
        // Save the context
        try? AppDelegate.viewContext.save()
    }
    
}

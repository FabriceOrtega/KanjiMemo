//
//  KanjiEntity.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 28/11/2020.
//

import Foundation
import CoreData

class KanjiEntity: NSManagedObject {
    static var all: [KanjiEntity] {
        
        // Charge and display saved data
        let request: NSFetchRequest<KanjiEntity> = KanjiEntity.fetchRequest()
        guard let kanjis = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return kanjis
    }
}



//
//  StatsEntity.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 29/11/2020.
//

import Foundation
import CoreData

class StatsEntity: NSManagedObject {
    static var all: [StatsEntity] {
        // Charge and display saved data
        let request: NSFetchRequest<StatsEntity> = StatsEntity.fetchRequest()
        guard let stats = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return stats
    }
}

//
//  AlarmEntity.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 14/12/2020.
//

import Foundation
import CoreData

class AlarmEntity: NSManagedObject {
    static var all: [AlarmEntity] {
        // Charge and display saved data
        let request: NSFetchRequest<AlarmEntity> = AlarmEntity.fetchRequest()
        guard let alarmEntity = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return alarmEntity
    }
}

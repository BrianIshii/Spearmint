//
//  LocalPersistance.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class LocalPersistance {
    private static var instance: LocalPersistance = LocalPersistance()
    var localPersistanceService: LocalPersistanceService

    private init() {
        self.localPersistanceService = LocalPersistanceService()
        //self.dataStores = []
        //self.dataStores.append(BaseStore)
    }
    
    static func getInstance() -> LocalPersistance {
        return LocalPersistance.instance
    }
    
    func getDataStore<SaveableClass: Saveable>(_ saveableType: SaveableClass.Type) {
        
    }
}

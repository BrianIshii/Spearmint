//
//  TransactionStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TransactionStore: BaseRepo<Transaction> {
    var observers: [Observer] = []

    override init(localPersistanceService: LocalPersistanceService) {
        super.init(localPersistanceService: localPersistanceService)
    }
    
    override func update() {
        super.update()
        updateObservers()
    }
}

extension TransactionStore: Observable {
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        observers.removeAll(where: {(o) -> Bool in return o === observer })
    }
    
    func updateObservers() {
        for observer in observers {
            observer.update()
        }
    }
}

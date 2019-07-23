//
//  Observable.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
protocol Observable {
    var observers: [Observer] { get set}
    
    func updateObservers()
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
}

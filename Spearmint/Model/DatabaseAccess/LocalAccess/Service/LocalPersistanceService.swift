//
//  LocalPersistanceService.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/21/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public class LocalPersistanceService: LocalPersistance {
    private let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!

    public init() {
    }
    
    public func getDictionary
        <K: SaveableKey, V: Saveable>(key: K.Type, object: V.Type) -> [K: V] {
        do {
            let url = documentsDirectory.appendingPathComponent(V.urlString)
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let dictionary = try decoder.decode([K: V].self, from: data)
            
            return dictionary
        } catch {
            print("Unable to get dictionary for \(K.self): \(error)")
        }
        
        return [:]
    }
    
    public func updateDictionary<K: SaveableKey, V: Saveable>(data: [K: V]) {
        let encoder = JSONEncoder()
        do {
            let url = documentsDirectory.appendingPathComponent(V.urlString)
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print("Unable to update dictionary for \(K.self): \(error)")
        }
    }
    
    public func getData<SaveableObject: Saveable>(saveable: SaveableObject.Type) -> [SaveableObject] {
        do {
            let url = documentsDirectory.appendingPathComponent(SaveableObject.urlString)
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let array = try decoder.decode([SaveableObject].self, from: data)
            
            return array
        } catch {
            print("Unable to get data for \(SaveableObject.self): \(error)")
        }
        
        return []
    }
    
    public func updateData<SaveableObject: Saveable>(data: [SaveableObject]) {
        let encoder = JSONEncoder()
        do {
            let url = documentsDirectory.appendingPathComponent(SaveableObject.urlString)
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print("Unable to update data for \(SaveableObject.self): \(error)")
        }
    }
}

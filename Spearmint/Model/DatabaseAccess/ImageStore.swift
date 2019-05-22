//
//  ImageStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/21/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

class ImageStore {
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    static func saveImage(_ image: UIImage, transactionID: TransactionID) {
        do {
            if let imageData = image.pngData() {
                try imageData.write(to: documentsDirectory.appendingPathComponent(transactionID.description() + ".png"))
            }
        } catch {
            print(error)
        }
    }
    
    static func getImage(transactionID: TransactionID) -> UIImage? {
        return UIImage(contentsOfFile: URL(fileURLWithPath: documentsDirectory.absoluteString).appendingPathComponent(transactionID.description() + ".png").path)
    }
    
    static func deleteImage(_ transactionID: TransactionID) {
        do {
            try FileManager().removeItem(atPath: URL(fileURLWithPath: documentsDirectory.absoluteString).appendingPathComponent(transactionID.description() + ".png").path)
        } catch  {
            print(error)
        }
    }
    
}

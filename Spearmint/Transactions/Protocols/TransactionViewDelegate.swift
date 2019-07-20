//
//  TransactionViewDelegate.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol TransactionViewDelegate {
    func didSelectCategoryButton()
    func didSelectTag(text: String)
    func didSelectVendor(_ vendorID: VendorID)
    func dismiss()
}

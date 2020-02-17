//
//  CategoryEntryAPI.swift
//  GrubHub
//
//  Created by Oliver Green on 08/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import Foundation

class CategoryEntryAPI {
    
    static func getCategoryData() -> [CategoryItemData] {
        let entry = [
            CategoryItemData(title: "Coffee", image: "coffee-icon"),
            CategoryItemData(title: "Pastries", image: "pastries-icon"),
            CategoryItemData(title: "Soft Drinks", image: "soft-drinks-icon"),
            CategoryItemData(title: "Tea", image: "default-flag"),
            CategoryItemData(title: "Smoothies", image: "default-flag")
        ]
        return entry
    }
}

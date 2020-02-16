//
//  CategoryEntryAPI.swift
//  GrubHub
//
//  Created by Oliver Green on 08/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import Foundation

class CategoryEntryAPI {
    
    static func getCategoryData() -> [CategoryEntry] {
        let entry = [
            CategoryEntry(title: "Coffee", image: "coffee-icon"),
            CategoryEntry(title: "Pastries", image: "pastries-icon"),
            CategoryEntry(title: "Soft Drinks", image: "soft-drinks-icon"),
            CategoryEntry(title: "Tea", image: "default-flag"),
            CategoryEntry(title: "Smoothies", image: "default-flag")
        ]
        return entry
    }
}

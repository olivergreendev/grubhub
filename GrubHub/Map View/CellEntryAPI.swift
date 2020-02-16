//
//  CellEntryAPI.swift
//  GrubHub
//
//  Created by Oliver Green on 04/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import Foundation

class CellEntryAPI {
    
    static func getCellData() -> [CellEntry] {
        let entry = [
            CellEntry(title: "Costa Coffee", distance: "0.2 miles", status: "star-true", latitude: 37.7620, longitude: -122.4348),
            CellEntry(title: "Starbucks", distance: "0.4 miles", status: "star-true", latitude: 37.772505, longitude: -122.440938),
            CellEntry(title: "Counsell's Blend", distance: "0.6 miles", status: "star-false", latitude: 37.774133, longitude: -122.428759),
            CellEntry(title: "Test Cell 1", distance: "0.8 miles", status: "star-false", latitude: 37.756051, longitude: -122.434285),
            CellEntry(title: "Test Cell 2", distance: "0.8 miles", status: "star-false", latitude: 37.761208, longitude: -122.425751),
            CellEntry(title: "Test Cell 3", distance: "0.8 miles", status: "star-false", latitude: 37.756322, longitude: -122.428239),
            CellEntry(title: "Test Cell 4", distance: "0.8 miles", status: "star-false", latitude: 37.762837, longitude: -122.424079)
        ]
        return entry
    }
}

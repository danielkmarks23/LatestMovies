//
//  Extensions.swift
//  Movies
//
//  Created by Daniel Marks on 15/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        if let year = components.year, let month = components.month, let day = components.day {
            
            return "\(year)-\(month)-\(day)"
        }
        
        return ""
    }
}

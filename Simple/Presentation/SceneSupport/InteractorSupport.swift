//
//  InteractorSupport.swift
//  Simple
//
//  Created by Mikael Weiss on 3/27/21.
//

import Foundation

class InteractorSupport {
    static func sanitize(dateString: String) -> String {
        var sanitizedDateString = dateString
        
        let dateFormatter = DateFormatter()
        var date: Date?
        let formats = ["MM/dd/yyyy", "M/dd/yyyy", "MM/d/yyyy", "M/d/yyyy", "dd MMM yyyy"]
        for format in formats {
            dateFormatter.dateFormat = format
            if let parsedDate = dateFormatter.date(from: dateString) {
                date = parsedDate
                break
            }
        }
        
        if let parsedDate = date {
            sanitizedDateString = DateFormatter.standard.string(from: parsedDate)
        }
        
        return sanitizedDateString
    }
}

//
//  FixDate.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 12/09/21.
//

import UIKit
// format date from string
func formattedDateFromString(dateString: String, dateFormat: String, toFormat: String) -> String? {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = dateFormat
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = toFormat
        return outputFormatter.string(from: date)
    }
    return nil
}

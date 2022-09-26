//
//  DateOfBirthModel.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation

struct DateOfBirthModel: Decodable {
    var date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
    }
    
    func getDateDisplay() -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"

        if let date = dateFormatterInput.date(from: self.date) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}

//
//  Extension+String.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import Foundation

extension String {
  func formatDate(from inputFormat: DateFormat, to outputFormat: DateFormat) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat.formatString
    guard let date = dateFormatter.date(from: self) else { return "" }
    dateFormatter.dateFormat = outputFormat.formatString
    return dateFormatter.string(from: date)
  }
}

enum DateFormat {
    case yyyyMMddHHmmss
    case ddMMyyyy
    
    var formatString: String {
        switch self {
        case .yyyyMMddHHmmss: return "yyyy-MM-dd HH:mm:ss"
        case .ddMMyyyy: return "dd-MM-yyyy"
        }
    }
}

//
//  TimeFormatting.swift
//  GolfScoreKeeper
//
//  Created by Brandon Anzalone on 3/23/22.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    let date = Date()
    let stringOfDate = dateFormatter.string(from: date)
    return(stringOfDate)
}

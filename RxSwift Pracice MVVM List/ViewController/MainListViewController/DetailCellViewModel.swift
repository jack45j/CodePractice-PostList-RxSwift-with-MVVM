//
//  DetailCellViewModel.swift
//  RxSwift Pracice MVVM List
//
//  Created by 林翌埕 on 2019/3/21.
//  Copyright © 2019 Benson Lin. All rights reserved.
//

import Foundation

struct DetailCellViewModel {
    let title: String
    let body: String
    let timestamp: String
}

extension DetailCellViewModel {
    init(post: Post) {
        title = post.title!
        body = post.body!
        timestamp = timestampFormatter.string(from:
            Date(timeIntervalSince1970:
                generateRandomDate(daysBack: Int(arc4random_uniform(100)))
            )
        )
    }
}

/// timestamp formatter
///
private var timestampFormatter: DateFormatter {
    let timeStampFormatter = DateFormatter()
    
    timeStampFormatter.dateFormat = "dd MMM yyyy"
    
    return timeStampFormatter
}

/// random a timestamp within the days back from today
///
private func generateRandomDate(daysBack: Int)-> TimeInterval {
    let day = arc4random_uniform(UInt32(daysBack))+1
    let hour = arc4random_uniform(23)
    let minute = arc4random_uniform(59)
    
    let today = Date(timeIntervalSinceNow: 0)
    let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    var offsetComponents = DateComponents()
    offsetComponents.day = Int(day - 1)
    offsetComponents.hour = Int(hour)
    offsetComponents.minute = Int(minute)
    
    let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0))
    return randomDate!.timeIntervalSince1970
}

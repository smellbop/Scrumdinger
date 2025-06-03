//
//  History.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import Foundation
import SwiftData

@Model
class History: Identifiable{
    var id: UUID
    var date: Date
    var attendees: [Attendee]
    var dailyScrum: DailyScrum?
    
    init(id: UUID = UUID(), date:Date = Date(), attendees: [Attendee]){
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}

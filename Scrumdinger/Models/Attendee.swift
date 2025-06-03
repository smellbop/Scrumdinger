//
//  Attendee.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//
import Foundation
import SwiftData

@Model
class Attendee: Identifiable {
        var id: UUID
        var name: String
        var dailyScrum: DailyScrum?
        
        init(id: UUID=UUID(), name:String){
            self.id = id
            self.name = name
        }
    }

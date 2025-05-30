//
//  DailyScrum+Sample.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design",
                   attendees: ["Cathy", "Daisy", "Elliot", "Grace"],
                   lengthInMinutes: 10,
                   theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Katie", "Liam", "Mia", "Nora"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["Olivia", "Poppy", "Quinn", "Ruby"], lengthInMinutes: 5, theme: .poppy)
    ]
}

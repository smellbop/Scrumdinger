//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 03/06/2025.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name})
    }
}

#Preview {
    let history = History(attendees: [
        Attendee(name: "Dave"),
        Attendee(name: "Maeve"),
        Attendee(name: "Edward")
    ],
                          transcript: "Every body be cool. You be cool."
    )
    
    HistoryView(history:   history)
}

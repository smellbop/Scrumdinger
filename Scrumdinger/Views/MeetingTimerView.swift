//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 03/06/2025.
//

import SwiftUI
import TimerKit
import ThemeKit

struct MeetingTimerView: View {
    
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted})?.name ?? "Someone"
    }
    
    var body: some View {
       Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: {$0.id == speaker.id}) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

#Preview {
    let speakers = [ScrumTimer.Speaker(name: "Bill", isCompleted: true),
                    ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    MeetingTimerView(speakers: speakers, theme: .yellow)
}

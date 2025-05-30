//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import SwiftUI
import TimerKit

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                Circle().strokeBorder(lineWidth: 24)
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear{
            scrumTimer.reset(
                lengthInMinutes: scrum.lengthInMinutes,
                attendeeNames: scrum.attendees.map { $0.name}
            )
            scrumTimer.startScrum()
        }
        .onDisappear{
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: $scrum)
}

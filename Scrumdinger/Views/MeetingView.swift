//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import SwiftUI
import TimerKit
import AVFoundation

struct MeetingView: View {
    @Environment(\.modelContext) private var context
    let scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    @Binding var errorWrapper: ErrorWrapper?
    
    private let player = AVPlayer.dingPlayer()
    
    private func startScrum() {
        scrumTimer.reset(
            lengthInMinutes: scrum.lengthInMinutes,
            attendeeNames: scrum.attendees.map { $0.name}
        )
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }
    
    private func endScrum() throws {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
        try context.save()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme)
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear{
            startScrum()
        }
        .onDisappear{
            do {
                try endScrum()
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "JFI, pal.")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
   var scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: scrum, errorWrapper: .constant(nil))
}

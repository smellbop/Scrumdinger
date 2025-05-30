//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import SwiftUI
import ThemeKit
import TimerKit

struct MeetingHeaderView: View {
    
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {
        Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack{
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack{
                VStack (alignment: .leading){
                    Text("Seconds elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack (alignment: .trailing){
                    Text("Seconds remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time Remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
}

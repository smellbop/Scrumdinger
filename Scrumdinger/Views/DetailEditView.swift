//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    let saveEdits: (DailyScrum) -> Void
    
    @State private var attendeeName = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Meeting Info")){
                    TextField("Title", text: $scrum.title)
                    HStack{
                        Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1){
                            Text("Length")
                        }
                        .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                        Spacer()
                        Text("\(scrum.lengthInMinutes) minutes")
                            .accessibilityHidden(true)
                    }
                    ThemePicker(selection: $scrum.theme)
                }
                
                Section(header: Text("Attendees")){
                    ForEach(scrum.attendees) { attendee in
                        Text(attendee.name)
                    }
                    .onDelete { indicies in
                        scrum.attendees.remove(atOffsets: indicies)
                    }
                    HStack {
                        TextField("New Attendee", text: $attendeeName)
                        Button(action: {
                            withAnimation {
                                let attendee = Attendee(name: attendeeName)
                                scrum.attendees.append(attendee)
                                attendeeName = ""
                            }
                        }){
                            Image(systemName: "plus.circle.fill")
                                .accessibilityLabel("Add attendee")
                        }
                        .disabled(attendeeName.isEmpty)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        saveEdits(scrum)
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    DetailEditView(scrum: $scrum, saveEdits: { _ in })
}

//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import SwiftUI
import ThemeKit
import SwiftData

struct DetailEditView: View {
    let scrum: DailyScrum
    
    @State private var attendeeName = ""
    @State private var title: String
    @State private var theme: Theme
    @State private var lengthInMinutesAsDouble: Double
    @State private var attendees: [Attendee]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    private let isCreatingScrum: Bool
    
    init(scrum: DailyScrum?){
        let scrumToEdit: DailyScrum
        if let scrum {
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
            isCreatingScrum = true
        }
        
        self.scrum = scrumToEdit
        self.title = scrumToEdit.title
        self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
        self.attendees = scrumToEdit.attendees
        self.theme = scrumToEdit.theme
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Meeting Info")){
                    TextField("Title", text: $title)
                    HStack{
                        Slider(value: $lengthInMinutesAsDouble, in: 5...30, step: 1){
                            Text("Length")
                        }
                        .accessibilityValue("\(String(format: "%.0f", lengthInMinutesAsDouble)) minutes")
                        Spacer()
                        Text("\(String(format: "%.0f", lengthInMinutesAsDouble)) minutes")
                            .accessibilityHidden(true)
                    }
                    ThemePicker(selection: $theme)
                }
                
                Section(header: Text("Attendees")){
                    ForEach(attendees) { attendee in
                        Text(attendee.name)
                    }
                    .onDelete { indicies in
                        attendees.remove(atOffsets: indicies)
                    }
                    HStack {
                        TextField("New Attendee", text: $attendeeName)
                        Button(action: {
                            withAnimation {
                                let attendee = Attendee(name: attendeeName)
                                attendees.append(attendee)
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
                        saveEdits()
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
    }
    
    private func saveEdits() {
        scrum.title = title
        scrum.theme = theme
        scrum.attendees = attendees
        scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
        
        if isCreatingScrum {
            context.insert(scrum)
        }
        
        try? context.save()
    }
}

#Preview {
    let scrum = DailyScrum.sampleData[0]
    DetailEditView(scrum: scrum)
}

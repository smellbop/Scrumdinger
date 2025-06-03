//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 30/05/2025.
//

import SwiftUI

struct NewScrumSheet: View {
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum:nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}

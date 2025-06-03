//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Elliot Pollard on 03/06/2025.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Gents, there's been a bit of a fuck up:")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThickMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Dismiss"){
                        dismiss()
                    }
                }
            }
        }
    }
}

private enum SampleError: Error {
    case errorRequired
}

#Preview {
    ErrorView(errorWrapper: ErrorWrapper(error: SampleError.errorRequired, guidance: "Kids, don't do it!"))
}

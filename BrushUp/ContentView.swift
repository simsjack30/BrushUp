//
//  ContentView.swift
//  BrushUp
//
//  Created by John Sims on 4/16/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("You are signed in!")
                .font(.title)
            Text("This is a demonstration of the Firebase Auth integration for CPSC-5340 Assignment 4. The remainder of this app will be implemented in the final project.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.top)
            Spacer()
                .frame(height: 40)
            Button("Sign Out") {
                viewModel.signOut()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(Capsule())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

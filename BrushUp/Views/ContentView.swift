import SwiftUI

struct ContentView: View {
    @StateObject var artistViewModel = ArtistViewModel()
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView {
            TabView {
                QuizView()
                    .tabItem {
                        Label("Quiz", systemImage: "questionmark")
                    }
                    .environmentObject(artistViewModel)
                StudyView()
                    .tabItem {
                        Label("Study", systemImage: "book")
                    }
                    .environmentObject(artistViewModel)
                LinksView()
                    .tabItem {
                        Label("Links", systemImage: "link")
                    }
                
                Button("Sign Out") {
                    viewModel.signOut()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .clipShape(Capsule())
                .tabItem {
                    Label("Sign Out", systemImage: "arrow.right.square")
                }
            }
            .navigationTitle("Brush Up")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

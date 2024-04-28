import SwiftUI

struct StudyView: View {
    @EnvironmentObject var viewModel: ArtistViewModel

    var body: some View {
        NavigationView {
            List(viewModel.artists, id: \.name) { artist in
                NavigationLink(destination: ArtistDetailView(viewModel: viewModel, artist: artist)) {
                    Text(artist.name)
                }
            }
            .navigationBarTitle("Select an Artist", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


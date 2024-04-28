import SwiftUI

struct ArtistDetailView: View {
    @ObservedObject var viewModel: ArtistViewModel
    var artist: Artist
    @State private var index = 0

    var body: some View {
        VStack {
            VStack {
                if let imageUrl = URL(string: viewModel.imageUrl) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                }
                Text(viewModel.title)
                    .font(.headline)
                    .padding()
            }
            Spacer()
            Button("Next Artwork") {
                index = (index + 1) % 10
                viewModel.fetchArtworkForArtist(artistName: artist.name, index: index)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.bottom)
        }
        .onAppear {
            viewModel.fetchArtworkForArtist(artistName: artist.name, index: index)
        }
    }
}

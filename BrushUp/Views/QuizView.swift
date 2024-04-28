import SwiftUI

struct QuizView: View {
    @EnvironmentObject var viewModel: ArtistViewModel
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var randomArtistIndex = 0
    @State private var randomArtworkIndex = 0

    // Define the grid layout
    private var gridItems: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)

    var body: some View {
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
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(viewModel.choices, id: \.self) { choice in
                    Button(action: {
                        checkAnswer(choice)
                    }) {
                        Text(choice)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: nil, dismissButton: .default(Text("Next"), action: {
                loadRandomArtwork()
            }))
        }
        .onAppear {
            loadRandomArtwork()
        }
    }

    private func loadRandomArtwork() {
        randomArtistIndex = Int.random(in: 0..<viewModel.artists.count)
        randomArtworkIndex = Int.random(in: 0..<3)
        viewModel.fetchArtworkForArtist(artistName: viewModel.artists[randomArtistIndex].name, index: randomArtworkIndex)
    }

    private func checkAnswer(_ answer: String) {
        if answer == viewModel.artists[randomArtistIndex].name {
            alertTitle = "Correct!"
        } else {
            alertTitle = "Wrong! The correct artist was \(viewModel.artists[randomArtistIndex].name)"
        }
        showAlert = true
    }
}

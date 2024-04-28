import Foundation

class ArtistViewModel: ObservableObject {
    @Published var artists: [Artist] = [
        Artist(name: "Auguste Renoir"),
        Artist(name: "Vincent van Gogh"),
        Artist(name: "Pablo Picasso"),
        Artist(name: "Rembrandt"),
        Artist(name: "Andy Warhol"),
        Artist(name: "Salvador Dali"),
        Artist(name: "Paul Cezanne"),
        Artist(name: "Henri Matisse"),
        Artist(name: "Caravaggio"),
        Artist(name: "Titian"),
        Artist(name: "Gustav Klimt"),
        Artist(name: "Albrecht Durer"),
        Artist(name: "Edvard Munch"),
        Artist(name: "Jackson Pollock"),
        Artist(name: "Michelangelo"),
        Artist(name: "Edgar Degas"),
        Artist(name: "Claude Monet")
    ]
    
    @Published var artistName: String = "Loading..."
    @Published var imageUrl: String = ""
    @Published var title: String = ""
    @Published var correctAnswer: String = ""
    @Published var choices: [String] = []
    
    
    func fetchArtworkForArtist(artistName: String, index: Int) {
        let urlString = "https://api.artic.edu/api/v1/artworks/search?query[match_phrase][artist_title]=\(artistName)&fields=id,image_id,title,artist_title"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.artistName = "Invalid URL"
                print("Invalid URL")
            }
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.artistName = "Failed to load data"
                    print("Failed to load data")
                }
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(ArtworkResponse.self, from: data)
                guard decodedResponse.data.indices.contains(index), let config = decodedResponse.config else {
                    DispatchQueue.main.async {
                        self?.artistName = "Artwork not found"
                        print("Artwork not found")
                    }
                    return
                }
                let selectedArtwork = decodedResponse.data[index]
                DispatchQueue.main.async {
                    self?.artistName = selectedArtwork.artistTitle
                    self?.imageUrl = "\(config.iiifUrl)/\(selectedArtwork.imageId)/full/843,/0/default.jpg"
                    self?.title = selectedArtwork.title
                    self?.generateChoices(correctAnswer: artistName)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.artistName = "Error decoding data"
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func generateChoices(correctAnswer: String) {
        var generatedChoices: [String] = [correctAnswer]
        while generatedChoices.count < 4 {
            if let randomArtist = artists.randomElement()?.name, !generatedChoices.contains(randomArtist) {
                generatedChoices.append(randomArtist)
            }
        }
        self.choices = generatedChoices.shuffled()
        print("Generated choices: \(self.choices)")
    }
}

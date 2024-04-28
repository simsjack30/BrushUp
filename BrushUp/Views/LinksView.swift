//
//  LinksView.swift
//  BrushUp
//
//  Created by John Sims on 4/27/24.
//

import Foundation
import SwiftUI

struct LinksView: View {
    let links = [
        ("Art Institute Chicago Public API", "http://api.artic.edu/docs/#introduction"),
        ("Metropolitan Museum of Art Public API", "https://metmuseum.github.io"),
        ("Wikipedia: Famous Artists", "https://en.wikipedia.org/wiki/Lists_of_artists"),
        ("Brush Up App Project Repository", "https://github.com/simsjack30"),
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(links, id: \.0) { link in
                    Button(action: {
                        openLink(urlString: link.1)
                    }) {
                        Text(link.0)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func openLink(urlString: String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
}

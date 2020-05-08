//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Structure that holds our view.
// Structures are value-based.
// Classes are reference-based.

// class UILabel -> Instance.
// struct var Text -> modifications -> Text


struct ContentView: View {
    
    // State is a source of truth, when this changes, the whole UI will be redrawn
    @State var artistName: String = "" // Whatever the user typed
    
    @State var artistGenre: String = ""
    
    var body: some View {
        VStack() {
            
            Text("Search for Artists in iTunes")
                .font(.subheadline)
            
            // Textfield is expecting a binding, a binding will help SwiftUI know that it needs to update one of our own custom variables. In order for us to have a custom variable like that, we need to use @State to wrap it.
            // $ Getter for the underlying binder
            SearchView(artistNameBinding: $artistName, primaryArtistGenreBinding: $artistGenre)
            
            Text(artistName) // Create our first text
                .font(.largeTitle) // Modify the text (-> a new text with the modifiation)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
            
            HStack() {
                
                Text("Artist Genre:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(artistGenre)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
}

// Structure that holds our preview.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

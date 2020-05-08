//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by Breena Greek on 5/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Access Control
//
// private - only be accessible inside your class
// fileprivate - only accessible inside the same file
// interal - only accessible in the same module
// public - accessible everwhere in the modules
// open - accessible everwhere _and_ subclassable
// final - cannot be sublassed. Opposite of open.

final class SearchView : NSObject, UIViewRepresentable {
    
    // Two- way street or bridge between two variables.
    // Binding itself is just a wrapper around artistName: String
    @Binding var artistName: String // The property its wrapping is artistName: String
    
    @Binding var artistGenre: String
    
    init(artistNameBinding: Binding<String>, primaryArtistGenreBinding: Binding<String>) {
        // in order to assign a binding to our variable
        _artistName = artistNameBinding
        _artistGenre = primaryArtistGenreBinding
    }
    
    // Tell the compiler what view we will be using while using UIViewRepresentable.
    // Generics via Associated Type
    typealias UIViewType = UISearchBar
    
    // Create our UIView
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
        return searchBar
    }
    
    // Update it every single time that SwiftUI update it.
    func updateUIView(_ searchBar: UISearchBar, context: Context) {
        searchBar.delegate = self
    }
}

// In order to become a UISearchBarDelegate - Be a class, be a final class, inherit from NSObject.
extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
//        artistName = searchBar.text!
        
        // Fetch user input, sending it to iTunes
        iTunesAPI.searchArtists(for: searchBar.text!) { result in
            
            // When the server responds, either get arties or error
            switch result {
            case .success(let artists):
                
                guard let firstArtist = artists.first else { return }
                
                // Update artistName string which triggers its own binding
                self.artistName = firstArtist.artistName
                self.artistGenre = firstArtist.primaryGenreName
                
            case .failure(let error):
                print(error)
            }
        }
        
        searchBar.endEditing(true)
    }
}

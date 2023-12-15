//
//  Created with ♥ by Serhii Pryimachuk on 24.11.2023.
//

import SwiftUI
import MilitarySymbologyKit

public struct MilitarySymbolSearchResults: View {
    @Binding public var searchText: String
    @Binding public var selectedSymbol: MilitarySymbol
    @Binding public var isSearchPresented: Bool

    private var searchResults: [MilitarySymbol]

    public init(
        searchText: Binding<String>,
        selectedSymbol: Binding<MilitarySymbol>,
        isSearchPresented: Binding<Bool>,
        searchResults: [MilitarySymbol]
    ) {
        _searchText = searchText
        _selectedSymbol = selectedSymbol
        _isSearchPresented = isSearchPresented
        self.searchResults = searchResults
    }

    private var searchState: SearchState {
        if !searchText.isEmpty && !searchResults.isEmpty {
            .showResults
        } else if !searchText.isEmpty && searchResults.isEmpty {
            .noResults
        } else {
            .showAll
        }
    }

    public var body: some View {
        switch searchState {
        case .showAll:
            MilitarySymbolForEach(for: searchResults) { selectedSymbol in
                self.selectedSymbol = selectedSymbol
                searchText = ""
                isSearchPresented = false
            }
        case .noResults:
            let comment: StaticString = "Symbol search"
            ContentUnavailableView(label: {
                Label(
                    title: {
                        Text("Not found", bundle: .militarySymbologyKit, comment: comment)
                    },
                    icon: {
                        Image(systemName: "questionmark.diamond")
                    }
                )
            }, description: {
                Text("No results for '\(searchText)'", bundle: .militarySymbologyKit, comment: comment)
            })
        case .showResults:
            MilitarySymbolForEach(for: searchResults) { selectedSymbol in
                self.selectedSymbol = selectedSymbol
                searchText = ""
                isSearchPresented = false
            }
        }
    }
}

private extension MilitarySymbolSearchResults {
    enum SearchState {
        case showAll, noResults, showResults
    }
}

/*
 private struct PreviewWprapper: View {
     @State private var text = ""
     @State private var symbol = MilitarySymbol()
     @State private var isSearchPresented = false

     var searchResults: [MilitarySymbol] {
         .allEntityCases(initialValue: symbol).filtered(searchText: text)
     }

     public var body: some View {
         List {
             MilitarySymbolSearchResults(searchText: $text,
                                         selectedSymbol: $symbol,
                                         isSearchPresented: $isSearchPresented,
                                         searchResults: searchResults)
         }
         .searchable(text: $text, isPresented: .constant(true))
     }
 }

 #Preview {
     NavigationStack {
         PreviewWprapper()
     }
 }
 */

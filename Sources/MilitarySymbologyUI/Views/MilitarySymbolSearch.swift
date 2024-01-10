//
//  Created with ♥ by Serhii Pryimachuk on 11.12.2023.
//

import SwiftUI
import MilitarySymbologyKit

public struct MilitarySymbolSearch: View {
    @Binding public var selectedSymbol: MilitarySymbol

    public init(selectedSymbol: Binding<MilitarySymbol>) {
        _selectedSymbol = selectedSymbol
        allSymbols = .allEntityCases(initialValue: selectedSymbol.wrappedValue)
    }

    @State private var searchText: String = ""
    @State private var isSearchPresented: Bool = true

    let allSymbols: [MilitarySymbol]

    private var filteredSymbols: [MilitarySymbol] {
        allSymbols.filtered(searchText: searchText)
    }

    public var body: some View {
        List {
            MilitarySymbolSearchResults(
                searchText: $searchText,
                selectedSymbol: $selectedSymbol,
                isSearchPresented: $isSearchPresented,
                searchResults: searchText.isEmpty
                    ? allSymbols
                    : filteredSymbols
            )
        }
        .animation(.linear, value: filteredSymbols)
        .searchable(
            text: $searchText,
            isPresented: $isSearchPresented,
            placement: searchPlacement,
            prompt: Text("Search symbol", bundle: .militarySymbologyKit, comment: "Search bar")
        )
    }
}

private extension MilitarySymbolSearch {
    var searchPlacement: SearchFieldPlacement {
#if os(iOS)
            .navigationBarDrawer
#else
            .toolbar
#endif
    }
}

/*
 fileprivate struct PreviewWrapper: View {
     @State private var symbol = MilitarySymbol()
     var body: some View {
         NavigationStack {
             MilitarySymbolSearch(selectedSymbol: $symbol)
         }
     }
 }

 #Preview {
     PreviewWrapper()
 }
 */

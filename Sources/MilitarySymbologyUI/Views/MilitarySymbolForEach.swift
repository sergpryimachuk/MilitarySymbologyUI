//
//  Created with ♥ by Serhii Pryimachuk on 11.12.2023.
//

import SwiftUI
import MilitarySymbologyKit

public struct MilitarySymbolForEach: View {
    public typealias SelectedMilitarySymbol = MilitarySymbol

    private let symbols: [MilitarySymbol]
    private let onSelected: (_: SelectedMilitarySymbol) -> Void

    public init(
        for symbols: [MilitarySymbol],
        onSelected: @escaping (_: SelectedMilitarySymbol) -> Void
    ) {
        self.symbols = symbols
        self.onSelected = onSelected
    }

    public var body: some View {
        ForEach(symbols) { symbol in
            Button {
                onSelected(symbol)
            } label: {
                HStack(spacing: 12) {
                    MilitarySymbolPreview(symbol: symbol, size: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Divider()
                    VStack(alignment: .leading) {
                        let isEntityTypeNone = symbol.entityType == .none
                        let isEntitySubtypeNone = symbol.entitySubtype == .none

                        if isEntityTypeNone
                            && isEntitySubtypeNone
                        {
                            Text(symbol.dimension.name)
                            Text(symbol.entity.name)
                        }

                        if !isEntityTypeNone {
                            Text(symbol.entityType.name)
                        }

                        if !isEntitySubtypeNone {
                            Text(symbol.entitySubtype.name)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .minimumScaleFactor(0.8)
                }
            }.tint(.primary)
        }
    }
}

//
//  Created with ♥ by Serhii Pryimachuk on 11.12.2023.
//

import SwiftUI
import MilitarySymbologyKit

/// For previewing MilitarySymbol.
/// It has a gray background to make sure all balck amplifiers are visible.
public struct MilitarySymbolPreview: View {
    private let symbol: MilitarySymbol
    private let size: CGFloat

    public init(symbol: MilitarySymbol, size: CGFloat = 140) {
        self.symbol = symbol
        self.size = size
    }

    private var backgroundFrameSize: CGFloat {
        size - (size / 3)
    }

    private var symbolPadding: CGFloat {
        -(size / 5)
    }

    public var body: some View {
        ZStack {
            ContainerRelativeShape()
                .frame(width: backgroundFrameSize, height: backgroundFrameSize)
                .foregroundStyle(.gray.opacity(0.25))

            symbol.makeView(size: size)
                .padding(symbolPadding)
        }
    }
}

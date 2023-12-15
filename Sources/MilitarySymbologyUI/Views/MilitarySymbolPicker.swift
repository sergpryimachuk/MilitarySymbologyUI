//
//  Created with ♥ by Serhii Pryimachuk on 10.11.2023.
//

import SwiftUI
import MilitarySymbologyKit

/// Form view for constructing MilitarySymbol with each property as a picker.
public struct MilitarySymbolPicker: View {
    @Binding public var symbol: MilitarySymbol

    public init(symbol: Binding<MilitarySymbol>) {
        _symbol = symbol
    }

    public var body: some View {
        Form {
            Section {
                symbol.makeView(size: 200)
                    .padding(-30)
                    .frame(maxWidth: .infinity, alignment: .center)

                LabeledContent("SIDC:", value: symbol.sidc)
                    .contextMenu {
                        Button("Copy", systemImage: "doc.on.doc") {
                            copyToPasteboard(symbol.sidc)
                        }
                    }
            }

            Section {
                Picker(selection: $symbol.context) {
                    ForEach(Context.allCases) { context in
                        Text(context.name).tag(context)
                    }
                } label: {
                    Text("Context", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.standardIdentity) {
                    ForEach(StandardIdentity.allCases) { identity in
                        Text(identity.name).tag(identity)
                    }
                } label: {
                    Text("Standard Identity", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.dimension) {
                    ForEach(Dimension.allCases) { dimension in
                        Text(dimension.name).tag(dimension)
                    }
                } label: {
                    Text("Dimension", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.status) {
                    ForEach(Status.allCases) { status in
                        Text(status.name).tag(status)
                    }
                } label: {
                    Text("Status", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.hqtfd) {
                    ForEach(HQTFD.allCases) { hqtfd in
                        Text(hqtfd.name).tag(hqtfd)
                    }
                } label: {
                    Text("HQ / Task Force / Dummy", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.amplifier) {
                    ForEach(Amplifier.allCases) { amplifier in
                        Text(amplifier.name).tag(amplifier)
                    }
                } label: {
                    Text("Amplifier", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.descriptor) {
                    ForEach(symbol.amplifier.descriptors) { descriptor in
                        Text(descriptor.name).tag(AnyDescriptor(descriptor))
                    }
                } label: {
                    Text("Descriptor", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.entity) {
                    ForEach(symbol.dimension.entities) { entity in
                        Text(entity.name).tag(entity)
                    }
                } label: {
                    Text("Entity", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.entityType) {
                    ForEach(symbol.entity.types) { entityType in
                        Text(entityType.name).tag(entityType)
                    }
                } label: {
                    Text("Entity Type", bundle: .militarySymbologyUI)
                }

                Picker(selection: $symbol.entitySubtype) {
                    ForEach(symbol.entityType.subtypes) { entitySubtype in
                        Text(entitySubtype.name).tag(entitySubtype)
                    }
                } label: {
                    Text("Entity Subtype", bundle: .militarySymbologyUI)
                }

                // This one is unclear when to use - let it be without it for now.

                /*
                 Toggle(isOn: $symbol.isCivilian) {
                 Text("Civilian", bundle: .militarySymbologyUI)
                 }
                 .disabled(symbol.standardIdentity == .suspect || symbol.standardIdentity == .hostile)
                 .onChange(of: symbol.standardIdentity) { _, newValue in
                 if newValue == .suspect || newValue == .hostile {
                 symbol.isCivilian = false
                 }
                 }
                 */

                Toggle(isOn: $symbol.isAlternateStatusAmplifiers) {
                    Text("Use alternate status amplifiers", bundle: .militarySymbologyUI)
                }

                Button(role: .destructive) {
                    symbol = MilitarySymbol()
                } label: {
                    Text("Reset to default value", bundle: .militarySymbologyUI)
                }
            }
        }
        .navigationTitle(symbol.entity.name + " - " + symbol.entityType.name)
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var searchFieldPlacement: SearchFieldPlacement {
        #if os(macOS)
            .automatic
        #else
            .navigationBarDrawer
        #endif
    }

    private func copyToPasteboard(_ string: String) {
        #if os(macOS)
            let pasteboard = NSPasteboard.general
            pasteboard.setString(string, forType: .string)
        #else
            let pasteboard = UIPasteboard.general
            pasteboard.string = string
        #endif
    }
}

/*
 fileprivate struct PreviewWrapper: View {

     @State private var symbol: MilitarySymbol = .init()

     var body: some View {
         NavigationStack {
             MilitarySymbolPicker(symbol: $symbol)
         }
     }
 }

 #Preview {
     PreviewWrapper()
 }
 */

//
//  AccessibilitySample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 24.03.2025.
//

import SwiftUI

struct AccessibilitySample: View {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 20))
                            Text("My stuff")
                                .font(.title)
                        }
                        Text("I don't know about being the best. It's just not enough my willpower. I'm weak. I'm not sure every time")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .truncationMode(.head)
                            .lineLimit(3)
                            .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                    }
//                    .frame(height: 100)
                    .background(.red)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("What a fuc i'm burning")
        }
    }
}

extension ContentSizeCategory {
    
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraLarge:
            return 0.8
        default:
            return 0.6
        }
    }
    
}

#Preview {
    AccessibilitySample()
}

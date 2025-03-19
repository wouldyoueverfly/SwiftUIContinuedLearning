//
//  MaskSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI

struct MaskSample: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        starsView
            .overlay(overlayView.mask(starsView))
    }
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    //.foregroundStyle(.pink)
                    .fill(LinearGradient(gradient: Gradient(colors: [.pink, .cyan]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        ZStack {
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.15)) {
                                rating = index
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    MaskSample()
}

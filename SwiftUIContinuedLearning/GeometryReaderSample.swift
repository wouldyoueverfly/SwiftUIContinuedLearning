//
//  GeometryReaderSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI

struct GeometryReaderSample: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - currentX / maxDistance)
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 20),
                                axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    
                }
            }
        }
        
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: geometry.size.width * 0.666)
//                Rectangle()
//                    .fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
        
    }
}

#Preview {
    GeometryReaderSample()
}

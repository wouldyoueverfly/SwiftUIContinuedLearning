//
//  TypealiasSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 21.03.2025.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasSample: View {
    
//    @State var item: MovieModel = MovieModel(title: "Place beyond the Pines", director: "Cianfrance", count: 11)
    
    @State var item: TVModel = TVModel(title: "TVShow", director: "Gosling", count: 4)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasSample()
}

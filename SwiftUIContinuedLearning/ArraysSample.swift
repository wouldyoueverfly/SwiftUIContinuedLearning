//
//  ArraysSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 20.03.2025.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        dataArray.append(contentsOf: [
            UserModel(name: "Nastya", points: 100, isVerified: false),
            UserModel(name: "Katya", points: 87, isVerified: false),
            UserModel(name: "Vika", points: 46, isVerified: true),
            UserModel(name: "Anya", points: 32, isVerified: false),
            UserModel(name: nil, points: 12, isVerified: false),
            UserModel(name: nil, points: 75, isVerified: true),
            UserModel(name: "Masha", points: 99, isVerified: false),
            UserModel(name: "Alisa", points: 56, isVerified: false),
            UserModel(name: "Sasha", points: 78, isVerified: true),
            UserModel(name: "Ksysha", points: 33, isVerified: false)
        ])
    }
    
    func updateFilteredArray() {
        // sort
        /*
        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
         */
        
        // filter
        /*
        filteredArray = dataArray.filter({ $0.name.contains("t") })
         */
        
        // map
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name
//        })
//        
//        mappedArray = dataArray.map({ $0.name })
        
//        mappedArray = dataArray.compactMap({ (user) -> String? in
//            return user.name
//        })
        
        mappedArray = dataArray.compactMap({ $0.name })
         */
        
        let sort = dataArray.sorted(by: { $0.points < $1.points })
        let filter = dataArray.filter({ $0.isVerified })
        let map = dataArray.compactMap({ $0.name })
        
        mappedArray = dataArray
            .sorted(by: { $0.points < $1.points })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
    }
}

struct ArraysSample: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        Divider()
//                            .background(.white)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "star.circle.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(.pink)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysSample()
}

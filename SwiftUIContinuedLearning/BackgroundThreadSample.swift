//
//  BackgroundThreadSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 21.03.2025.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK 1:")
            print("isMainThread: \(Thread.isMainThread)")
            print("currentThread: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 2:")
                print("isMainThread: \(Thread.isMainThread)")
                print("currentThread: \(Thread.current)")
            }
            
        }

    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadSample: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Data".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadSample()
}

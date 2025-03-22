//
//  EscapingSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 21.03.2025.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "New Data"
    }
    
    
    func downloadData2(completionHadler: (_ data: String) -> Void) {
        completionHadler("New Data")
    }
    
    func downloadData3(completionHadler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHadler("New Data")
        }
    }
    
    func downloadData4(completionHadler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data")
            completionHadler(result)
        }
    }
    
    func downloadData5(completionHadler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data")
            completionHadler(result)
        }
    }
    
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct DownloadResult {
    let data: String
}

struct EscapingSample: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingSample()
}

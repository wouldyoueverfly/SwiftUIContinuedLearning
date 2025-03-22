//
//  CodableSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 21.03.2025.
//

import SwiftUI

struct CustomerModel: Identifiable, Codable {
    let name: String
    let points: Int
    let isPremium: Bool
    let id: String
    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case points
//        case isPremium
//        case id
//    }
//    
//    init(name: String, points: Int, isPremium: Bool, id: String) {
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//        self.id = id
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
    
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
//        do {
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print("Error decoding. Error:\(error)")
//        }
        
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String:Any],
//            
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool
//        {
//            let newCustomer = CustomerModel(name: name, points: points, isPremium: isPremium, id: id)
//            customer = newCustomer
//        }
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(name: "Mames Zond", points: 99, isPremium: false, id: "008")
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String:Any] = [
//            "id" : "007",
//            "name" : "James Bond",
//            "points" : 10000,
//            "isPremium" : true
//        ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
}

struct CodableSample: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableSample()
}

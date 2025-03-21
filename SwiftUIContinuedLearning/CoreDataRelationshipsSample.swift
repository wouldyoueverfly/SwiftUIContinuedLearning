//
//  CoreDataRelationshipsSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 20.03.2025.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("saved successfully")
        } catch let error {
            print("error saving Core Data. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
//         newBusiness.departments = [departments[0], departments[1]]
        
        // add existing employees to the new business
//         newBusiness.employees = [employees[1]]
        
        // add new business to existing department
        // newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        // newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        newDepartment.addToEmployees(employees[1])
        
        //newDepartment.employees = [employees[1]]
        newDepartment.addToEmployees(employees[1])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 20
        newEmployee.dateJoined = Date()
        newEmployee.name = "Lyuba"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        save()
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching data. \(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching data. \(error.localizedDescription)")
        }
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching data. \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching data. \(error.localizedDescription)")
        }
    }
    
    func deleteDepartment() {
        let department = departments[1]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
        
    }
}

struct CoreDataRelationshipsSample: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button("Perform Action") {
                        vm.deleteDepartment()
                    }
                    .font(.title2)
                    .foregroundStyle(.wb)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    .scrollIndicators(.visible)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    .scrollIndicators(.visible)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                    .scrollIndicators(.visible)
                }
                .padding()
            }
            .navigationTitle("Relashionships")
        }
    }
}

#Preview {
    CoreDataRelationshipsSample()
}


struct BusinessView: View {
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name:")
                .bold(true)
            Text("\(entity.name ?? "No Name")")
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold(true)
                ForEach(departments) { department in
                    Text(department.name ?? "No Name")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold(true)
                ForEach(employees) { employee in
                    Text(employee.name ?? "No Name")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(.blue.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name:")
                .bold(true)
            Text("\(entity.name ?? "No Name")")
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold(true)
                ForEach(businesses) { business in
                    Text(business.name ?? "No Name")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold(true)
                ForEach(employees) { employee in
                    Text(employee.name ?? "No Name")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(.green.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct EmployeeView: View {
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Name:")
                .bold(true)
            Text("\(entity.name ?? "No Name")")
            
            Text("Age:")
                .bold(true)
            Text("\(entity.age)")
            
            Text("Date Joined:")
                .bold(true)
            Text("\(entity.dateJoined ?? Date())")
            
            
            Text("Business:")
                .bold(true)
            Text(entity.business?.name ?? "No Businesses")
            
            
            Text("Department:")
                .bold(true)
            Text(entity.department?.name ?? "No Department")
            
        }
        .padding()
        .frame(maxWidth: 300)
        .background(.orange.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

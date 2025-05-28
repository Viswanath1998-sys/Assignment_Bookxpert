//
//  CoreDataStack.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import Foundation
import CoreData

class CoreDataStack{
    static let shared = CoreDataStack()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Bookxpert_Assignment")
        container.loadPersistentStores { description, error in
            if let err = error{
                print("Error Loading CoreData\(err)")
            }else{
                print("succesfully loaded CoreData!")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext{
        return container.viewContext
    }
    
    func save(){
        let context = container.viewContext
        do{
            // save the data
            try context.save()
            print("Successfully Saved Data to coredata!!")
        }catch let error{
            print("Error saving... \(error)")
        }
    }
}

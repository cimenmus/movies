//
//  PersonLocalDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift
import CoreData

struct PersonLocalDataSource: PersonDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return DatabaseResource<PersonModel>(
            dbRequest: {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonEntity")
                request.predicate = NSPredicate(format: "id = %i", personId)
                request.returnsObjectsAsFaults = false
                
                do {
                    let results = try self.context.fetch(request) as! [NSManagedObject]
                    if results.count > 0 {
                        let entity = results[0]
                        return PersonModel(id: entity.value(forKey: "id") as? Int,
                                           name: entity.value(forKey: "name") as? String,
                                           biography: entity.value(forKey: "biography") as? String,
                                           imagePath: entity.value(forKey: "imagePath") as? String)
                    } else {
                        return nil
                    }
                    
                } catch {
                    return nil
                }
            }
        ).execute()
    }
    
    func savePerson(person: PersonModel) {
        
        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(person.id, forKey: "id")
        managedObject.setValue(person.name, forKey: "name")
        managedObject.setValue(person.biography, forKey: "biography")
        managedObject.setValue(person.imagePath, forKey: "imagePath")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}

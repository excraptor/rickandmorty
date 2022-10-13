//
//  Database.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 12..
//

import Foundation
import CoreData

class DataController {
    lazy var container = NSPersistentContainer(name: "Characters")
    lazy var managedContext: NSManagedObjectContext  = container.viewContext
    
    public static var instance: DataController = DataController()
    
    private init() {
        // print(container.persistentStoreDescriptions.first?.url)
        container.loadPersistentStores { description, error in
                if let error = error {
                    print("Core Data failed to load: \(error.localizedDescription)")
                }
            }
    }
    
    func getFavourites() -> [Character]? {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        do {
            // Peform Fetch Request
            let characters = try managedContext.fetch(fetchRequest)

            return characters
        } catch {
            print("Unable to Fetch Workouts, (\(error))")
        }
        return nil
    }
    
    func saveCharacter(character: CharacterModel) {
        if !isFavourite(id: character.id) {
            let entity = NSEntityDescription.entity(forEntityName: "Character", in: managedContext)
            let newCharacter = NSManagedObject(entity: entity!, insertInto: managedContext)
            newCharacter.setValue(character.id, forKey: "id")
            newCharacter.setValue(character.name, forKey: "name")
            newCharacter.setValue(character.url, forKey: "url")
            saveContext()
        }
    }
    
    func isFavourite(id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        let isInDatabase: NSPredicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = isInDatabase
        do {
            let char = try  managedContext.fetch(fetchRequest)
            if char.isEmpty {
                return false
            }
        } catch {
            print("Unable to fetch request, ", error)
        }
        return true
    }
    
    func removeCharacter(id: Int) {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        let isInDatabase: NSPredicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = isInDatabase
        do {
            let char = try  managedContext.fetch(fetchRequest)
            managedContext.delete(char[0])
            saveContext()
        } catch {
            print("Unable to fetch request, ", error)
        }
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
}

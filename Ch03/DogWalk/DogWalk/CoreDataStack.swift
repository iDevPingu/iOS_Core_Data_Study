//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by Ick on 2021/06/19.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  private let modelName: String
  
  init(modelName: String) {
    self.modelName = modelName
  }
  
  private lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  /// NSMAnagedObjectContext는 CoreDataStack에 유일하게 접근 할 수 있는 부분
  /// 나머지 스택에 접근할 때 필요한 유일한 진입점
  lazy var managedContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  func saveContext() {
    guard managedContext.hasChanges else { return }
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
}

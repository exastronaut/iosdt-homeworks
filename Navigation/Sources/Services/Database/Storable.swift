//
//  Storable.swift
//  Navigation
//
//  Created by Artem Sviridov on 30.11.2022.
//

import CoreData

protocol Storable { }

extension NSManagedObject: Storable { }

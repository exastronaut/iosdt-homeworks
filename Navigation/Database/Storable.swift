//
//  Storable.swift
//  Navigation
//
//  Created by Artem Sviridov on 09.11.2022.
//

import Foundation
import RealmSwift

protocol Storable {}

extension Object: Storable {}

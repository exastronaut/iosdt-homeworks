//
//  ProfileDataStore.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

protocol StoresProfile: AnyObject {
    var postModels: [PostModel] { get set }
}

final class ProfileDataStore: StoresProfile {
    var postModels: [PostModel] = []
}

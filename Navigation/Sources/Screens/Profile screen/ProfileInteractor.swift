//
//  ProfileInteractor.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    func getPostsFromDatabase(completion: @escaping (ProfileInteractor.Response, String?) -> Void)
    func deletePostFromDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void)
    func addPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void)
    func checkPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void)
}

final class ProfileInteractor {
    private let provider: ProvidesProfile
    private lazy var database: DatabaseCoordinatable = provider.getCoreDataDatabase()

    init(provider: ProvidesProfile) {
        self.provider = provider
    }
}

// MARK: - ProfileInteractorProtocol

extension ProfileInteractor: ProfileInteractorProtocol {
    func deletePostFromDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void) {
        let predicate = NSPredicate(format: "uid == %@", post.uid)
        database.delete(PostCoreDataModel.self, predicate: predicate) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    func addPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void) {
        database.create(PostCoreDataModel.self, keyedValues: [post.keyedValues]) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    func checkPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void) {
        database.fetchAll(PostCoreDataModel.self) { result in
            switch result {
            case .success(let posts):
                if !posts.contains(where: { $0.uid == post.uid } ) {
                    completion(true, nil)
                } else {
                    completion(false, nil)
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    func getPostsFromDatabase(completion: @escaping (Response, String?) -> Void) {
        var response = Response()
        database.fetchAll(PostCoreDataModel.self) { result in
            switch result {
            case .success(let data):
                response = data.map { PostModel(postCoreDataModel: $0) }
                completion(response, nil)
            case .failure(let error):
                completion(response, error.localizedDescription)
            }
        }
    }
}

extension ProfileInteractor {
    typealias Response = [PostModel]
}

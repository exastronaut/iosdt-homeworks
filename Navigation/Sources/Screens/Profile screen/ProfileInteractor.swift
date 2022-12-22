//
//  ProfileInteractor.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import CoreData
import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    func getPostsFromDatabase(completion: @escaping (ProfileInteractor.Response, String?) -> Void)
    func deletePostFromDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void)
    func addPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void)
    func checkPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void)
}

final class ProfileInteractor: NSObject {
    private let provider: ProvidesProfile
    private lazy var database: DatabaseCoordinatable = provider.getCoreDataDatabase()
    private var context: NSManagedObjectContext?
    private var fetchedResultsController: NSFetchedResultsController<PostCoreDataModel>?

    init(provider: ProvidesProfile) {
        self.provider = provider
        super.init()

        makeContext()
        makeFetchedResultsController(for: context)
    }

    private func makeContext() {
        context = provider.getContext()
    }

    private func makeFetchedResultsController(for context: NSManagedObjectContext?) {
        guard let context = context else { return }

        let request = PostCoreDataModel.fetchRequest()
        request.sortDescriptors = []

        fetchedResultsController = .init(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        fetchedResultsController?.delegate = self
    }
}

// MARK: - ProfileInteractorProtocol

extension ProfileInteractor: ProfileInteractorProtocol {
    func deletePostFromDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void) {
        guard let context = context else { return }

        do {
            try fetchedResultsController?.performFetch()
            let models = fetchedResultsController?.fetchedObjects

            if let object = models?.first(where: { $0.uid == post.uid }) {
                context.delete(object)
                try context.save()

                completion(true, nil)
            }
        } catch let error {
            completion(false, error.localizedDescription)
        }
    }

    func addPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void) {
        guard let context = context else { return }

        let object = PostCoreDataModel(context: context)
        object.uid = post.uid
        object.imageName = post.imageName
        object.author = post.author
        object.content = post.content
        object.numberOfLikes = post.numberOfLikes
        object.numberOfViews = post.numberOfViews

        do {
            try context.save()
            
            completion(true, nil)
        } catch let error {
            completion(false, error.localizedDescription)
        }
    }

    func checkPostInDatabase(_ post: PostModel, completion: @escaping (Bool, String?) -> Void) {
        do {
            try fetchedResultsController?.performFetch()
            let models = fetchedResultsController?.fetchedObjects

            if let models = models, !models.contains(where: { $0.uid == post.uid } ) {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        } catch let error {
            completion(false, error.localizedDescription)
        }
    }

    func getPostsFromDatabase(completion: @escaping (Response, String?) -> Void) {
        var response = Response()
        do {
            try fetchedResultsController?.performFetch()

            if let models = fetchedResultsController?.fetchedObjects {
                response = models.map { PostModel(postCoreDataModel: $0 ) }
            }

            completion(response, nil)
        } catch let error {
            completion(response, error.localizedDescription)
        }
    }
}

extension ProfileInteractor {
    typealias Response = [PostModel]
}

extension ProfileInteractor: NSFetchedResultsControllerDelegate { }

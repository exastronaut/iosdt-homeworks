//
//  PostModel.swift
//  Navigation
//
//  Created by Артем Свиридов on 15.04.2022.
//

struct PostModel {
    var uid: String
    var author: String
    var content: String
    var imageName: String
    var numberOfLikes: String
    var numberOfViews: String

    var keyedValues: [String: Any] {
        return [
            "uid": self.uid,
            "author": self.author,
            "content": self.content,
            "imageName": self.imageName,
            "numberOfLikes": self.numberOfLikes,
            "numberOfViews": self.numberOfViews,
        ]
    }

    init(
        uid: String,
        author: String,
        content: String,
        imageName: String,
        numberOfLikes: String,
        numberOfViews: String
    ) {
        self.uid = uid
        self.author = author
        self.content = content
        self.imageName = imageName
        self.numberOfLikes = numberOfLikes
        self.numberOfViews = numberOfViews
    }

    init(postCoreDataModel: PostCoreDataModel) {
        uid = postCoreDataModel.uid ?? .emptyString
        author = postCoreDataModel.author ?? .emptyString
        content = postCoreDataModel.content ?? .emptyString
        imageName = postCoreDataModel.imageName ?? .emptyString
        numberOfLikes = postCoreDataModel.numberOfLikes ?? .emptyString
        numberOfViews = postCoreDataModel.numberOfViews ?? .emptyString
    }
}

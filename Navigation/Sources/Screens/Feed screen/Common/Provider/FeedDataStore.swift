//
//  FeedDataStore.swift
//  Navigation
//
//  Created by Artem Sviridov on 05.12.2022.
//

protocol StoresFeed: AnyObject {
    var postModels: [PostModel] { get set }
}

final class FeedDataStore: StoresFeed {
    var postModels: [PostModel] = Constants.models
}

private extension FeedDataStore {
    enum Constants {
        static let models: [PostModel] = [
            .init(
                uid: "1",
                author: "Memus",
                content: "infinite SOCIAL CREDIT hack 100% working FREE by Zhong Xina",
                imageName: "post1",
                numberOfLikes: "34875",
                numberOfViews: "742358"
            ),
            .init(
                uid: "2",
                author: "Zelgius5631E",
                content: "Super Idol Full Song",
                imageName: "post2",
                numberOfLikes: "290",
                numberOfViews: "12232"
            ),
            .init(
                uid: "3",
                author: "Zhong Xina",
                content: "I'm speaking chinese and eating ice cream",
                imageName: "post3",
                numberOfLikes: "9000",
                numberOfViews: "9000"
            ),
            .init(
                uid: "4",
                author: "Li Han Myeon",
                content: "剪梅 (Yi Jian Mei) - 費玉清 (Fei Yu Qing)",
                imageName: "post4",
                numberOfLikes: "54",
                numberOfViews: "3331"
            )
        ]
    }
}


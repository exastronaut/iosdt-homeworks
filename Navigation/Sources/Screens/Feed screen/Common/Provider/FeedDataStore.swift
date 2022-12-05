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
                author: "Memus",
                description: "infinite SOCIAL CREDIT hack 100% working FREE by Zhong Xina",
                image: "post1",
                likes: 34875,
                views: 742358
            ),
            .init(
                author: "Zelgius5631E",
                description: "Super Idol Full Song",
                image: "post2",
                likes: 290,
                views: 12232
            ),
            .init(
                author: "Zhong Xina",
                description: "I'm speaking chinese and eating ice cream",
                image: "post3",
                likes: 9000,
                views: 9000
            ),
            .init(
                author: "Li Han Myeon",
                description: "剪梅 (Yi Jian Mei) - 費玉清 (Fei Yu Qing)",
                image: "post4",
                likes: 54,
                views: 3331
            )
        ]
    }
}


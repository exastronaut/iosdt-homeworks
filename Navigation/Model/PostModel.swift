//
//  PostModel.swift
//  Navigation
//
//  Created by Артем Свиридов on 15.04.2022.
//

import Foundation

struct PostModel {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int

    static func makeMockModel() -> [[PostModel]] {
        var model = [[PostModel]]()
        var section = [PostModel]()
        section.append(PostModel(author: "Memus", description: "infinite SOCIAL CREDIT hack 100% working FREE by Zhong Xina", image: "post1", likes: 34875, views: 742358))
        section.append(PostModel(author: "Zelgius5631E", description: "Super Idol Full Song", image: "post2", likes: 290, views: 12232))
        section.append(PostModel(author: "Zhong Xina", description: "I'm speaking chinese and eating ice cream", image: "post3", likes: 9000, views: 9000))
        section.append(PostModel(author: "Li Han Myeon", description: "剪梅 (Yi Jian Mei) - 費玉清 (Fei Yu Qing)", image: "post4", likes: 54, views: 3331))
        model.append(section)
        return model
    }
}

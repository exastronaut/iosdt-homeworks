//
//  FeedScreenIO.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

protocol FeedScreenOutput: AnyObject {
    func loadData()
    func didTapCell(_ index: Int)
}

protocol FeedScreenInput: AnyObject {
    func displayData(_ viewModel: FeedPresenter.ViewModel)
}

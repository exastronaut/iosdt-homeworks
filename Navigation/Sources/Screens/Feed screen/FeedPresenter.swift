//
//  FeedPresenter.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

final class FeedPresenter {
    private unowned let view: FeedScreenInput
    private let interactor: FeedInteractorProtocol
    private weak var moduleOutput: FeedModuleOutput?

    init(view: FeedScreenInput,
         interactor: FeedInteractorProtocol,
         moduleOutput: FeedModuleOutput?) {
        self.view = view
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

// MARK: - FeedScreenOutput

extension FeedPresenter: FeedScreenOutput {
    func didTapCell(_ index: Int) { }

    func loadData() {
        let response = interactor.getData()
        var viewModel = ViewModel()
        viewModel.append(contentsOf: response)
        view.displayData(viewModel)
    }
}

extension FeedPresenter {
    typealias Response = [PostModel]
    typealias ViewModel = [PostModel]
}

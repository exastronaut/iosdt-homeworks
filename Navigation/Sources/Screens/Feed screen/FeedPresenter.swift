//
//  FeedPresenter.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

final class FeedPresenter {
    private unowned let view: FeedScreenInput
    private weak var moduleOutput: FeedModuleOutput?

    init(view: FeedScreenInput,
         moduleOutput: FeedModuleOutput?) {
        self.view = view
        self.moduleOutput = moduleOutput
    }
}

// MARK: - FeedScreenOutput

extension FeedPresenter: FeedScreenOutput {
    func didTapButton() {
        moduleOutput?.didTapButton()
    }
}

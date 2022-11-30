//
//  LogInPresenter.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

final class LogInPresenter {

    private unowned let view: LogInScreenInput
    private weak var moduleOutput: LogInModuleOutput?

    init(view: LogInScreenInput,
         moduleOutput: LogInModuleOutput?) {
        self.view = view
        self.moduleOutput = moduleOutput
    }
}

// MARK: - LogInScreenOutput

extension LogInPresenter: LogInScreenOutput {
    func didTapLogInButton() {
        moduleOutput?.didTapLogInButton()
    }
}

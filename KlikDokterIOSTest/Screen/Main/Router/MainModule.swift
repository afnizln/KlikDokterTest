//
//  MainModule.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 01/10/23.
//

import UIKit

final class MainModule: IModule {
    
    private let appRouter: IAppRouter
    
    init(_ appRouter: IAppRouter) {
        self.appRouter = appRouter
    }
    
    func presentView(parameters: [String : Any]) {
        let view: UIViewController = createView(parameters: parameters)
        appRouter.presentView(view: view)
    }
    
    func createView(parameters: [String : Any]) -> UIViewController {
        let presenter: MainPresenter = MainPresenter()
        let networkService: NetworkService = NetworkService()
        let interactor: IMainInteractor = MainInteractor(presenter: presenter, networkService: networkService)
        let router = MainRouter(appRouter: appRouter)
        let viewController: MainViewController = MainViewController(interactor: interactor, router: router)
        presenter.view = viewController
        
        return viewController
    }
    
    
}

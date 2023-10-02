//
//  MainRouter.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 02/10/23.
//

import UIKit

protocol IMainRouter: AnyObject {
    func showErrorAlert(_ message: String)
}

class MainRouter: IMainRouter {
    private let appRouter: IAppRouter
    
    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }
    
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Failed!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        appRouter.presentView(view: alert, presentType: .present, animated: true, completion: nil)
    }
    
}

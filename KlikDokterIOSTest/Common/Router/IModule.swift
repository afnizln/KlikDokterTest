//
//  IModule.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 01/10/23.
//

import UIKit

protocol IModule {
    init(_ appRouter: IAppRouter)
    func presentView(parameters: [String: Any])
    func createView(parameters: [String: Any]) -> UIViewController
}

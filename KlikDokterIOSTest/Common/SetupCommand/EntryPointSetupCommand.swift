//
//  EntryPointSetupCommand.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 01/10/23.
//

import UIKit

struct EntryPointSetupCommand: ISetupCommand {
    
    let scene: UIScene
    
    func execute() {
        AppRouter.scene = scene
        AppRouter.shared.presentModule(module: MainModule.self)
    }
}

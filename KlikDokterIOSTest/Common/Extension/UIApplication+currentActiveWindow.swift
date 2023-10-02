//
//  UIApplication+currentActiveWindow.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 01/10/23.
//

import UIKit

extension UIApplication {
    var currentActiveWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

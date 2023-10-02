//
//  BaseAppRouter.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 01/10/23.
//

import UIKit

enum PresentType {
    case push
    case present
}

protocol IAppRouter {
    func presentModule(module: IModule.Type, parameters: [String: Any])
    func presentView(view: UIViewController, presentType: PresentType, animated: Bool, completion: (() -> Void)?)
}

extension IAppRouter {
    func presentModule(module: IModule.Type, parameters: [String: Any] = [:]) {
        presentModule(module: module, parameters: parameters)
    }
    
    func presentView(view: UIViewController, presentType: PresentType = .push, animated: Bool = true, completion: (() -> Void)? = nil) {
        presentView(view: view, presentType: presentType, animated: animated, completion: completion)
    }
}

class BaseAppRouter: IAppRouter {
    var window: UIWindow?
    
    func presentModule(module: IModule.Type, parameters: [String: Any]) {
        let module = module.init(self)
        module.presentView(parameters: parameters)
    }
    
    func presentView(view: UIViewController, presentType: PresentType, animated: Bool, completion: (() -> Void)?) {
        guard window?.rootViewController != nil else {
            let navigationController: UINavigationController = UINavigationController(rootViewController: view)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            return
        }
        
        switch presentType {
        case .push:
            getNavigation()?.pushViewController(view, animated: true)
            completion?()
        case .present:
            UIApplication.topViewController()?.present(view, animated: animated, completion: completion)
        }
    }
}

extension BaseAppRouter {
    func getNavigation() -> UINavigationController? {
        var navigationController: UINavigationController?
        
        if let nav = UIApplication.topViewController()?.navigationController {
            navigationController = nav
        } else if let vc = (window?.rootViewController as? UITabBarController)?.selectedViewController {
            if let nav = vc.navigationController {
                navigationController = nav
            }
        } else if let nav = window?.rootViewController?.navigationController {
            navigationController = nav
        } else if let nav = UIApplication.topViewController()?.children.first?.children.first?.children.first?.navigationController {
            navigationController = nav
        } else if let nav = UIApplication.topViewController()?.children.first?.children.first?.navigationController {
            navigationController = nav
        } else {
            navigationController = UIApplication.topViewController()?.children.last?.children.first?.navigationController
        }
        
        return navigationController
    }
}

extension UIApplication {
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.currentActiveWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}

//
//  MainPresenter.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 02/10/23.
//

import Foundation

protocol IMainPresenter: AnyObject {
    func presentGreetingView(message: String)
    func presentSuccessGetTopPosts(response: TopPostsModel)
    func presentFailedGetTopPosts(message: String)
    func presentSuccessGetTopPhotos(response: TopPhotosModel)
    func presentFailedGetTopPhotos(message: String)
}

class MainPresenter: IMainPresenter {
    weak var view: IMainViewController?
    
    func presentGreetingView(message: String) {
        view?.presentGreetingView(message: message)
    }
    
    func presentSuccessGetTopPosts(response: TopPostsModel) {
        let data = response.data
        let topPosts = Array(data.prefix(10))
        view?.onSuccessGetTopPosts(data: topPosts)
    }
    
    func presentFailedGetTopPosts(message: String) {
        view?.onFailedGetTopPosts(message: message)
    }
    
    func presentSuccessGetTopPhotos(response: TopPhotosModel) {
        let data = response.data
        let topPhotos = Array(data.prefix(10))
        view?.onSuccessGetTopPhotos(data: topPhotos)
    }
    
    func presentFailedGetTopPhotos(message: String) {
        view?.onFailedGetTopPhotos(message: message)
    }
    
}

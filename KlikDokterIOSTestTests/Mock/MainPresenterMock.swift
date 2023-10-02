//
//  MainPresenterMock.swift
//  KlikDokterIOSTestTests
//
//  Created by Afni Laili on 02/10/23.
//

import UIKit

@testable import KlikDokterIOSTest

class MainPresenterMock: IMainPresenter {
    var presentGreetingViewCalled: Int = 0
    var presentSuccessGetTopPostsCalled: Int = 0
    var presentFailedGetTopPostsCalled: Int = 0
    var presentSuccessGetTopPhotosCalled: Int = 0
    var presentFailedGetTopPhotosCalled: Int = 0
    
    var greetingMessage: String?
    var topPostsModel: TopPostsModel?
    var topPhotosModel: TopPhotosModel?
    var errorMessage: String?
    
    func presentGreetingView(message: String) {
        presentGreetingViewCalled += 1
        greetingMessage = message
    }
    
    func presentSuccessGetTopPosts(response: TopPostsModel) {
        presentSuccessGetTopPostsCalled += 1
        topPostsModel = response
    }
    
    func presentFailedGetTopPosts(message: String) {
        presentFailedGetTopPostsCalled += 1
        errorMessage = message
    }
    
    func presentSuccessGetTopPhotos(response: TopPhotosModel) {
        presentSuccessGetTopPhotosCalled += 1
        topPhotosModel = response
    }
    
    func presentFailedGetTopPhotos(message: String) {
        presentFailedGetTopPhotosCalled += 1
        errorMessage = message
    }
}

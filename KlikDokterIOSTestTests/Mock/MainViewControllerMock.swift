//
//  MainViewControllerMock.swift
//  KlikDokterIOSTestTests
//
//  Created by Afni Laili on 02/10/23.
//

import XCTest

@testable import KlikDokterIOSTest

class MainViewControllerMock: IMainViewController {
    
    var presentGreetingViewCalled: Int = 0
    var onSuccessGetTopPostsCalled: Int = 0
    var onFailedGetTopPostsCalled: Int = 0
    var onSuccessGetTopPhotosCalled: Int = 0
    var onFailedGetTopPhotosCalled: Int = 0
    
    var greetingMessage: String?
    var postData: [TopPostsModel.Response]?
    var photosData: [TopPhotosModel.Response]?
    var errorMessage: String?
    
    func presentGreetingView(message: String) {
        presentGreetingViewCalled += 1
        greetingMessage = message
    }
    
    func onSuccessGetTopPosts(data: [TopPostsModel.Response]) {
        onSuccessGetTopPostsCalled += 1
        postData = data
    }
    
    func onFailedGetTopPosts(message: String) {
        onFailedGetTopPostsCalled += 1
        errorMessage = message
    }
    
    func onSuccessGetTopPhotos(data: [TopPhotosModel.Response]) {
        onSuccessGetTopPhotosCalled += 1
        photosData = data
    }
    
    func onFailedGetTopPhotos(message: String) {
        onFailedGetTopPhotosCalled += 1
        errorMessage = message
    }
}

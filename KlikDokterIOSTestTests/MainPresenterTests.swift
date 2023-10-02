//
//  MainPresenterTests.swift
//  KlikDokterIOSTestTests
//
//  Created by Afni Laili on 02/10/23.
//

import XCTest

@testable import KlikDokterIOSTest

class MainPresenterTest: XCTestCase {
    var sut: MainPresenter!
    
    var view: MainViewControllerMock!
    
    override func setUp() {
        super.setUp()
        view = MainViewControllerMock()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        sut = nil
    }
    
    func testPresentGreetingView() {
        sut = MainPresenter()
        sut.view = view
        
        sut.presentGreetingView(message: "GreetingMessage")
        
        XCTAssertEqual(view.presentGreetingViewCalled, 1)
        XCTAssertEqual(view.greetingMessage, "GreetingMessage")
    }
    
    func testPresentSuccessGetTopPosts() {
        let json = JSONParser.shared.fetchJSON(jsonFileName: "TopPostsDataMockResponse")
        let model = TopPostsModel(json)
        
        sut = MainPresenter()
        sut.view = view
        
        sut.presentSuccessGetTopPosts(response: model)
        
        XCTAssertEqual(view.onSuccessGetTopPostsCalled, 1)
        XCTAssertEqual(view.postData?.count, 10)
        XCTAssertNil(view.errorMessage)
    }
    
    func testPresentFailedGetTopPosts() {
        sut = MainPresenter()
        sut.view = view
        
        sut.presentFailedGetTopPosts(message: "ErrorMessagePosts")
        
        XCTAssertEqual(view.onFailedGetTopPostsCalled, 1)
        XCTAssertEqual(view.errorMessage, "ErrorMessagePosts")
        XCTAssertNil(view.postData)
    }
    
    func testPresentSuccessGetTopPhotos() {
        let json = JSONParser.shared.fetchJSON(jsonFileName: "TopPhotosDataMockResponse")
        let model = TopPhotosModel(json)
        
        sut = MainPresenter()
        sut.view = view
        
        sut.presentSuccessGetTopPhotos(response: model)
        
        XCTAssertEqual(view.onSuccessGetTopPhotosCalled, 1)
        XCTAssertEqual(view.photosData?.count, 10)
        XCTAssertNil(view.errorMessage)
    }
    
    func testPresentFailedGetTopPhotos() {
        sut = MainPresenter()
        sut.view = view
        
        sut.presentFailedGetTopPhotos(message: "ErrorMessagePhotos")
        
        XCTAssertEqual(view.onFailedGetTopPhotosCalled, 1)
        XCTAssertEqual(view.errorMessage, "ErrorMessagePhotos")
        XCTAssertNil(view.photosData)
    }
}

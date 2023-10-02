//
//  MainInteractorTests.swift
//  KlikDokterIOSTestTests
//
//  Created by Afni Laili on 02/10/23.
//

import XCTest

@testable import KlikDokterIOSTest

class MainInteractorTest: XCTestCase {
    var sut: MainInteractor!
    
    var presenter: MainPresenterMock!
    var networkService: NetworkServiceMock!
    
    override func setUp() {
        super.setUp()
        presenter = MainPresenterMock()
        networkService = NetworkServiceMock()
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        networkService = nil
        sut = nil
    }
    
    func testLoadGreetingMorning() {
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "HH:mm"
        guard let morningDate = formatter.date(from: "07:30") else {
            return
        }
        
        sut.loadGreeting(date: morningDate)
        
        XCTAssertEqual(presenter.presentGreetingViewCalled, 1)
        XCTAssertEqual(presenter.greetingMessage, "Good Morning,\nAfni Laili")
    }
    
    func testLoadGreetingAfternoon() {
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "HH:mm"
        guard let afternoonDate = formatter.date(from: "13:30") else {
            return
        }
        
        sut.loadGreeting(date: afternoonDate)
        
        XCTAssertEqual(presenter.presentGreetingViewCalled, 1)
        XCTAssertEqual(presenter.greetingMessage, "Good Afternoon,\nAfni Laili")
    }
    
    func testLoadGreetingEvening() {
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "HH:mm"
        guard let eveningDate = formatter.date(from: "20:30") else {
            return
        }
        
        sut.loadGreeting(date: eveningDate)
        
        XCTAssertEqual(presenter.presentGreetingViewCalled, 1)
        XCTAssertEqual(presenter.greetingMessage, "Good Evening,\nAfni Laili")
    }
    
    func testSuccessFetchTopPost() {
        networkService.isSuccess = true
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        sut.fetchTopPost()
        
        XCTAssertEqual(presenter.presentSuccessGetTopPostsCalled, 1)
        XCTAssertEqual(presenter.topPostsModel?.data.count, 100)
        XCTAssertNil(presenter.errorMessage)
    }
    
    func testErrorFetchTopPost() {
        networkService.isSuccess = false
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        sut.fetchTopPost()
        
        XCTAssertEqual(presenter.presentFailedGetTopPostsCalled, 1)
        XCTAssertNil(presenter.topPostsModel)
        XCTAssertNotNil(presenter.errorMessage)
    }
    
    func testSuccessFetchTopPhotos() {
        networkService.isSuccess = true
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        sut.fetchTopPhotos()
        
        XCTAssertEqual(presenter.presentSuccessGetTopPhotosCalled, 1)
        XCTAssertEqual(presenter.topPhotosModel?.data.count, 5000)
        XCTAssertNil(presenter.errorMessage)
    }
    
    func testErrorFetchTopPhotos() {
        networkService.isSuccess = false
        sut = MainInteractor(presenter: presenter, networkService: networkService)
        
        sut.fetchTopPhotos()
        
        XCTAssertEqual(presenter.presentFailedGetTopPhotosCalled, 1)
        XCTAssertNil(presenter.topPhotosModel)
        XCTAssertNotNil(presenter.errorMessage)
    }
}

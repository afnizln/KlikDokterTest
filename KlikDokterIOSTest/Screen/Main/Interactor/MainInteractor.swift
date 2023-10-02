//
//  MainInteractor.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 02/10/23.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol IMainInteractor {
    func loadGreeting(date: Date)
    func fetchTopPost()
    func fetchTopPhotos()
}

extension IMainInteractor {
    func loadGreeting() {
        loadGreeting(date: Date())
    }
}

class MainInteractor: IMainInteractor {
    let presenter: IMainPresenter
    let networkService: INetworkService
    
    init(presenter: IMainPresenter, networkService: INetworkService) {
        self.presenter = presenter
        self.networkService = networkService
    }
    
    func loadGreeting(date: Date) {
        let name: String = "Afni Laili"
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "id_ID")
        
        guard let intDate = Int(dateFormatter.string(from: date)) else {
            return
        }
        
        var greetingLabel: String = ""
        
        switch intDate {
        case 0..<5, 18..<24:
            greetingLabel = "Good Evening,\n"
        case 5..<12:
            greetingLabel = "Good Morning,\n"
        case 12..<18:
            greetingLabel = "Good Afternoon,\n"
        default:
            break
        }
        
        greetingLabel.append(name)
        
        presenter.presentGreetingView(message: greetingLabel)
    }
    
    func fetchTopPost() {
        networkService.fetch(url: MainURL.posts) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let json):
                self.presenter.presentSuccessGetTopPosts(response: TopPostsModel(json))
            case .failure(_):
                self.presenter.presentFailedGetTopPosts(message: "There was an error connecting to the server")
            }
        }
    }
    
    func fetchTopPhotos() {
        networkService.fetch(url: MainURL.photos) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let json):
                self.presenter.presentSuccessGetTopPhotos(response: TopPhotosModel(json))
            case .failure(_):
                self.presenter.presentFailedGetTopPhotos(message: "There was an error connecting to the server")
            }
        }
    }
    
}

//
//  MainViewModel.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 02/10/23.
//

import Foundation

struct MainViewModel {
    var topPosts: [TopPostsModel.Response] = []
    var topPhotos: [TopPhotosModel.Response] = []
    
    func topPostNumberOfItems() -> Int {
        return topPosts.count
    }
    
    func topPhotosNumberOfItem() -> Int {
        return topPhotos.count
    }
    
    func topPostsCellForItemAt(index: Int) -> TopPostsModel.Response {
        return topPosts[index]
    }
    
    func topPhotosCellForItemAt(index: Int) -> TopPhotosModel.Response {
        return topPhotos[index]
    }
}

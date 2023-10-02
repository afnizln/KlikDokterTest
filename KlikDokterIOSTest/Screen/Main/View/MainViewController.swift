//
//  MainViewController.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 29/09/23.
//

import UIKit

protocol IMainViewController: AnyObject {
    func presentGreetingView(message: String)
    func onSuccessGetTopPosts(data: [TopPostsModel.Response])
    func onFailedGetTopPosts(message: String)
    func onSuccessGetTopPhotos(data: [TopPhotosModel.Response])
    func onFailedGetTopPhotos(message: String)
}

class MainViewController: UIViewController {
    let interactor: IMainInteractor
    let router: IMainRouter
    var viewModel: MainViewModel = MainViewModel()
    
    private lazy var greetingView: GreetingView = {
        let view: GreetingView = GreetingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var topPostView: TopPostsView = {
        let view: TopPostsView = TopPostsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var topPhotosView: TopPhotosView = {
        let view: TopPhotosView = TopPhotosView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    init(interactor: IMainInteractor, router: IMainRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        setConstraint()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadGreeting()
        interactor.fetchTopPost()
        interactor.fetchTopPhotos()
    }
    
    private func setConstraint() {
        view.addSubview(greetingView)
        view.addSubview(topPostView)
        view.addSubview(topPhotosView)
        
        NSLayoutConstraint.activate([
            greetingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            greetingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            greetingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            greetingView.heightAnchor.constraint(equalToConstant: 58),
            
            topPostView.topAnchor.constraint(equalTo: greetingView.bottomAnchor, constant: 30),
            topPostView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topPostView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topPostView.heightAnchor.constraint(equalToConstant: 220),
            
            topPhotosView.topAnchor.constraint(equalTo: topPostView.bottomAnchor, constant: 20),
            topPhotosView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topPhotosView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topPhotosView.heightAnchor.constraint(equalToConstant: 302),
        ])
    }
}

//MARK: -

extension MainViewController: IMainViewController {
    func presentGreetingView(message: String) {
        greetingView.configureGreetingLabel(message: message)
    }
    
    func onSuccessGetTopPosts(data: [TopPostsModel.Response]) {
        viewModel.topPosts = data
        DispatchQueue.main.async {
            self.topPostView.reloadData()
        }
    }
    
    func onFailedGetTopPosts(message: String) {
        router.showErrorAlert(message)
    }
    
    func onSuccessGetTopPhotos(data: [TopPhotosModel.Response]) {
        viewModel.topPhotos = data
        DispatchQueue.main.async {
            self.topPhotosView.reloadData()
        }
    }
    
    func onFailedGetTopPhotos(message: String) {
        router.showErrorAlert(message)
    }
}

//MARK: -

extension MainViewController: TopPostsViewDelegate {
    func numberOfItemsInSection(_ view: TopPostsView, section: Int) -> Int {
        return viewModel.topPostNumberOfItems()
    }
    
    func modelForItemAt(_ view: TopPostsView, indexPath: IndexPath) -> TopPostsModel.Response {
        return viewModel.topPostsCellForItemAt(index: indexPath.item)
    }
}

extension MainViewController: TopPhotosViewDelegate {
    func numberOfItemsInSection(_ view: TopPhotosView, section: Int) -> Int {
        viewModel.topPhotosNumberOfItem()
    }
    
    func modelForItemAt(_ view: TopPhotosView, indexPath: IndexPath) -> TopPhotosModel.Response {
        viewModel.topPhotosCellForItemAt(index: indexPath.item)
    }
    
}


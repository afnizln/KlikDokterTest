//
//  TopPostsView.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 29/09/23.
//

import UIKit

protocol TopPostsViewDelegate: AnyObject {
    func numberOfItemsInSection(_ view: TopPostsView, section: Int) -> Int
    func modelForItemAt(_ view: TopPostsView, indexPath: IndexPath) -> TopPostsModel.Response
}

class TopPostsView: UIView {
    lazy var topPostTitleLabel: UILabel = createLabel("Top 10 Posts")
    weak var delegate: TopPostsViewDelegate?
    
    lazy var postCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 250, height: 150)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        
        let view = createCollectionView(with: layout)
        view.register(TopPostCollectionViewCell.self, forCellWithReuseIdentifier: "TopPostCollectionViewCell")
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    //MARK: -
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        postCollectionView.reloadData()
    }
    
    private func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    private func createCollectionView(with layout: UICollectionViewFlowLayout) -> UICollectionView {
        let view = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        return view
    }
    
    private func setConstraint() {
        addSubview(topPostTitleLabel)
        addSubview(postCollectionView)
        
        NSLayoutConstraint.activate([
            topPostTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topPostTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            topPostTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            postCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            postCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            postCollectionView.topAnchor.constraint(equalTo: topPostTitleLabel.bottomAnchor, constant: 8),
            postCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
        ])
    }
}

extension TopPostsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfItemsInSection(self, section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopPostCollectionViewCell", for: indexPath) as? TopPostCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = delegate?.modelForItemAt(self, indexPath: indexPath)
        cell.setData(model: model)
        return cell
    }
    
    
}



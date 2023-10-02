//
//  TopPhotosView.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 30/09/23.
//

import UIKit

protocol TopPhotosViewDelegate: AnyObject {
    func numberOfItemsInSection(_ view: TopPhotosView, section: Int) -> Int
    func modelForItemAt(_ view: TopPhotosView, indexPath: IndexPath) -> TopPhotosModel.Response
}

class TopPhotosView: UIView {
    lazy var topPhotosTitleLabel: UILabel = createLabel("Top 10 Photos")
    weak var delegate: TopPhotosViewDelegate?
    
    lazy var topPhotosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 174, height: 236)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        
        let view = createCollectionView(with: layout)
        view.register(TopPhotosCollectionViewCell.self, forCellWithReuseIdentifier: "TopPhotosCollectionViewCell")
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    //MARK: -
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        topPhotosCollectionView.reloadData()
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
        addSubview(topPhotosTitleLabel)
        addSubview(topPhotosCollectionView)
        
        NSLayoutConstraint.activate([
            topPhotosTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topPhotosTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            topPhotosTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            topPhotosCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            topPhotosCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            topPhotosCollectionView.topAnchor.constraint(equalTo: topPhotosTitleLabel.bottomAnchor, constant: 8),
            topPhotosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}

extension TopPhotosView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfItemsInSection(self, section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopPhotosCollectionViewCell", for: indexPath) as? TopPhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = delegate?.modelForItemAt(self, indexPath: indexPath)
        cell.setData(model: model)
        
        return cell
    }
    
    
}

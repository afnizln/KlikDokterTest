//
//  TopPhotosCollectionViewCell.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 30/09/23.
//

import UIKit
import Kingfisher

class TopPhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .lightGray
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 3
        return view
    }()
    
    //MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(model: TopPhotosModel.Response?) {
        titleLabel.text = model?.title
        setupImage(url: model?.imageUrl ?? "")
    }
    
    private func setupImage(url: String) {
        guard let url: URL = URL(string: url) else {
            return
        }
        imageView.kf.setImage(with: url)
    }
    
    private func setConstraint() {
        addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(imageView)
        backgroundViewCell.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundViewCell.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundViewCell.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: 12),
            imageView.leftAnchor.constraint(equalTo: backgroundViewCell.leftAnchor, constant: 12),
            imageView.rightAnchor.constraint(equalTo: backgroundViewCell.rightAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: backgroundViewCell.bottomAnchor, constant: -20)
            
        ])
    }
}

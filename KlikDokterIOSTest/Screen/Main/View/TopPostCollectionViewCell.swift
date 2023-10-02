//
//  TopPostCollectionViewCell.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 29/09/23.
//

import UIKit

class TopPostCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
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
        
        backgroundColor = .clear
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(model: TopPostsModel.Response?) {
        titleLabel.text = model?.title
        descLabel.text = model?.body
    }
    
    private func setConstraint() {
        addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(titleLabel)
        backgroundViewCell.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundViewCell.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundViewCell.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: backgroundViewCell.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: backgroundViewCell.rightAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descLabel.leftAnchor.constraint(equalTo: backgroundViewCell.leftAnchor, constant: 12),
            descLabel.rightAnchor.constraint(equalTo: backgroundViewCell.rightAnchor, constant: -12),
            descLabel.bottomAnchor.constraint(lessThanOrEqualTo: backgroundViewCell.bottomAnchor, constant: -20)
        ])
    }
    
}

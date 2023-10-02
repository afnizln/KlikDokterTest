//
//  GreetingView.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 30/09/23.
//

import UIKit

class GreetingView: UIView {
    lazy var greetingLabel: UILabel = createLabel("")
    
    init() {
        super.init(frame: .zero)
        
        greetingLabel.text = "Good Morning," + "\n" + "<Your name here>"
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureGreetingLabel(message: String) {
        greetingLabel.text = message
    }
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }
    
    private func setConstraint() {
        addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor),
            greetingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            greetingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            greetingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

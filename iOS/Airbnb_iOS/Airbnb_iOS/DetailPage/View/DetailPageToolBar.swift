//
//  DetailPageToolBar.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/07.
//

import UIKit

class DetailPageToolBar: UIView {
    
    private let costLabel: UILabel = {
        let cost = UILabel()
        cost.font = .systemFont(ofSize: 17, weight: .semibold)
        cost.translatesAutoresizingMaskIntoConstraints = false
        return cost
    }()
    
    private let dateLabel: UILabel = {
        let date = UILabel()
        date.font = .systemFont(ofSize: 15)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private let reserveButton: UIButton = {
        let reserve = UIButton()
        let attributedString = NSMutableAttributedString(string: "예약하기", attributes: [ NSAttributedString.Key.kern: 0.37, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)])
        
        reserve.setAttributedTitle(attributedString, for: .normal)
        reserve.setTitleColor(UIColor.white, for: .normal)
        reserve.backgroundColor = .black
        reserve.translatesAutoresizingMaskIntoConstraints = false
        return reserve
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setContstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setCostLabel(text: String?) {
        costLabel.text = text
    }
    
    func setDateLabel(text: String?) {
        dateLabel.text = text
    }
}

private extension DetailPageToolBar {
    
    func setContstraint() {
        self.addSubViews(costLabel, dateLabel, reserveButton)
        
        NSLayoutConstraint.activate([
            costLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            costLabel.widthAnchor.constraint(equalToConstant: 164),
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            costLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: costLabel.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: costLabel.widthAnchor),
            dateLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            reserveButton.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 16),
            reserveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reserveButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            reserveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
}

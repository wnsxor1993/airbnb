//
//  TitleTextCell.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import UIKit

class TitleTextCell: UICollectionViewCell {
    
    static let identifier = "TitleTextCell"

    private let roomName: UILabel = {
        let room = UILabel()
        room.font = .systemFont(ofSize: 22)
        room.numberOfLines = 0
        room.lineBreakMode = .byWordWrapping
        room.translatesAutoresizingMaskIntoConstraints = false
        return room
    }()
    
    private let rateStar: UIImageView = {
        let star = UIImageView(image: UIImage(systemName: "star.fill"))
        star.tintColor = .primary
        star.translatesAutoresizingMaskIntoConstraints = false
        return star
    }()
    
    private let rateText: UILabel = {
        let rate = UILabel()
        rate.font = .systemFont(ofSize: 15)
        rate.translatesAutoresizingMaskIntoConstraints = false
        return rate
    }()
    
    private let lotateText: UILabel = {
        let lotate = UILabel()
        lotate.font = .systemFont(ofSize: 15)
        lotate.translatesAutoresizingMaskIntoConstraints = false
        return lotate
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.configure(name: nil, rate: nil, lotate: nil)
    }

    func configure(name: String?, rate: String?, lotate: String?) {
        roomName.text = name
        rateText.text = rate
        lotateText.text = lotate
    }
}

private extension TitleTextCell {

    func setLayout() {
        contentView.addSubViews(roomName, rateStar, rateText, lotateText)

        NSLayoutConstraint.activate([
            roomName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roomName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            roomName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            roomName.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            rateStar.leadingAnchor.constraint(equalTo: roomName.leadingAnchor),
            rateStar.widthAnchor.constraint(equalToConstant: 20),
            rateStar.topAnchor.constraint(equalTo: roomName.bottomAnchor, constant: 10),
            rateStar.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            rateText.leadingAnchor.constraint(equalTo: rateStar.trailingAnchor, constant: 2),
            rateText.trailingAnchor.constraint(equalTo: roomName.trailingAnchor),
            rateText.topAnchor.constraint(equalTo: rateStar.topAnchor),
            rateText.heightAnchor.constraint(equalTo: rateStar.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lotateText.leadingAnchor.constraint(equalTo: roomName.leadingAnchor),
            lotateText.trailingAnchor.constraint(equalTo: roomName.trailingAnchor),
            lotateText.topAnchor.constraint(equalTo: rateText.bottomAnchor, constant: 10),
            lotateText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

//
//  HostTextCell.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import UIKit

class HostTextCell: UICollectionViewCell {
    
    static let identifier = "HostTextCell"

    private let roomInfo: UILabel = {
        let room = UILabel()
        room.font = .systemFont(ofSize: 22)
        room.textColor = .gray1
        room.translatesAutoresizingMaskIntoConstraints = false
        return room
    }()
    
    private let hostName: UILabel = {
        let hostName = UILabel()
        hostName.font = .systemFont(ofSize: 22)
        hostName.textColor = .gray1
        hostName.translatesAutoresizingMaskIntoConstraints = false
        return hostName
    }()
    
    private let hostImage: UIImageView = {
        let hostImage = UIImageView()
        hostImage.clipsToBounds = true
        hostImage.translatesAutoresizingMaskIntoConstraints = false
        return hostImage
    }()
    
    private let detailText: UILabel = {
        let detail = UILabel()
        detail.font = .systemFont(ofSize: 17)
        detail.textColor = .gray3
        detail.translatesAutoresizingMaskIntoConstraints = false
        return detail
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
        self.configure(info: nil, name: nil, image: nil, detail: nil)
    }

    func configure(info: String?, name: String?, image: UIImage?, detail: String?) {
        roomInfo.text = info
        hostName.text = name
        hostImage.image = image
        detailText.text = detail
    }
}

private extension HostTextCell {

    func setLayout() {
        self.addSubViews(roomInfo, hostName, hostImage, detailText)

        NSLayoutConstraint.activate([
            roomInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roomInfo.widthAnchor.constraint(equalToConstant: 270),
            roomInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            roomInfo.heightAnchor.constraint(equalToConstant: 28)
        ])

        NSLayoutConstraint.activate([
            hostName.leadingAnchor.constraint(equalTo: roomInfo.leadingAnchor),
            hostName.widthAnchor.constraint(equalTo: roomInfo.widthAnchor),
            hostName.topAnchor.constraint(equalTo: roomInfo.bottomAnchor, constant: 8),
            hostName.heightAnchor.constraint(equalTo: roomInfo.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            hostImage.leadingAnchor.constraint(equalTo: roomInfo.trailingAnchor, constant: 16),
            hostImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hostImage.topAnchor.constraint(equalTo: roomInfo.topAnchor),
            hostImage.bottomAnchor.constraint(equalTo: hostName.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailText.leadingAnchor.constraint(equalTo: roomInfo.leadingAnchor),
            detailText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailText.topAnchor.constraint(equalTo: hostName.bottomAnchor, constant: 16),
            detailText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        
        self.hostImage.layer.cornerRadius = hostImage.frame.width / 3
    }
}

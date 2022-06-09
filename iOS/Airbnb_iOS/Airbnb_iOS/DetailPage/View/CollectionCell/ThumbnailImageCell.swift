//
//  ThumbnailView.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import UIKit

final class ThumbnailImageCell: UICollectionViewCell {
    
    static let identifier = "ThumbnailImageCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureImage(imageData: UIImage?) {
        imageView.image = imageData
    }
}

private extension ThumbnailImageCell {
    
    func setLayout() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

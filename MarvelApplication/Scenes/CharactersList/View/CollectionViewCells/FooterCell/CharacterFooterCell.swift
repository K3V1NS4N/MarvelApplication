//
//  CharacterFooterCell.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 24/10/21.
//

import UIKit

class CharacterFooterCell: UICollectionReusableView {
    
    static let identifier = "CharacterFooterCell"
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    private let title: UILabel = {
        let title = UILabel()
        title.text = "Error"
        title.font = title.font.withSize(16)
        title.textAlignment = .center
        title.textColor = UIColor.gray
        title.numberOfLines = 0
        return title
    }()
    
    private let container: UIView = {
        let container = UIView()
        return container
    }()
    
    public func configure() {
        configureIndicator()
    }
    public func startLoading() {
        self.title.isHidden = true
        self.activityIndicator.startAnimating()
    }
    
    public func stopLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    public func showMessage(description: String) {
        backgroundColor = .clear
        addSubview(container)
        container.addSubview(title)
        title.text = description
        title.translatesAutoresizingMaskIntoConstraints = false
        title.pinLeading(toLeadingOf: self, constant: -24)
        title.pinTrailing(toTrailingOf: self, constant: -24)
        title.alignHorizontalAxis(toSameAxisOfView: container)
        title.setHeight(to: 64)
        title.isHidden = false
    }
    
    private func configureIndicator() {
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        self.activityIndicator.color = UIColor.darkGray
        self.addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.frame = bounds
    }
    
}

//
//  CharacterCell.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import UIKit
import AlamofireImage
    
public class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.loader.hidesWhenStopped = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(model: CharacterCellModel) {
        let ext = model.imageExt
        configureName(name: model.name)
        configureImage(imagePath: model.imagePath,
                       ext: ext)
        configureViews()
        configureLoader()
    }
    
    private func configureLoader() {
        self.loader.color = UIColor.darkGray
        if #available(iOS 13.0, *) {
            self.loader.style = .large
        } else {
            self.loader.style = .whiteLarge
        }
    }
    
    private func configureImage(icon: UIImage) {
        self.characterImageView.image = icon
    }
    
    private func configureName(name: String) {
        self.nameLabel.textColor = .black
        self.nameLabel.text = name
    }
    
    private func configureViews() {
        let cornerRadius: CGFloat = 10
        self.topView.roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
        self.bottomView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
        
    }
    
    private func configureImage(imagePath: String, ext: String) {
        let pathWithExtension = imagePath.addExtension(ext: ext)
        let securizedPath = pathWithExtension.securizePath()
        guard let securizedPath = securizedPath else {
            self.characterImageView.image = .notFoundIcon
            return
        }
        
        self.loader.startAnimating()
        self.characterImageView.image = nil
        self.characterImageView.af.setImage(withURL: securizedPath,
                                            imageTransition: .crossDissolve(0.25),
                                            completion: { response in
            
            if let image = response.value {
                self.characterImageView.image = image
            } else {
                self.characterImageView.image = .notFoundIcon
            }
            self.loader.stopAnimating()
        })
    }
        
}

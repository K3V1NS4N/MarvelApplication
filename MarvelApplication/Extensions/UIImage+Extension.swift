//
//  UIImage+Extension.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 24/10/21.
//

import UIKit

extension UIImage {
    
    public class var connectionErrorIcon: UIImage { get { return UIImage.named("ConnectionError").withRenderingMode(.alwaysOriginal) } }
    public class var serverErrorIcon: UIImage { get { return UIImage.named("ServerError").withRenderingMode(.alwaysOriginal) } }
    public class var filterIcon: UIImage { get { return UIImage.named("filter").withRenderingMode(.alwaysOriginal) } }
    public class var notFoundIcon: UIImage { get { return UIImage.named("notFound").withRenderingMode(.alwaysOriginal) } }
    public class var infoIcon: UIImage { get { return UIImage.named("Info").withRenderingMode(.alwaysOriginal) } }
    
    private static func named(_ imageName: String) -> UIImage {
        guard let image = self.init(named: imageName, in: Bundle(for: CharacterListViewController.self), compatibleWith: nil) else {
            fatalError("Missing image resource: \(imageName)")
        }
        return image
    }
    
    public static func getAVCImage(from name: String) -> UIImage {
        return UIImage.named(name).withRenderingMode(.alwaysOriginal)
    }
    
}

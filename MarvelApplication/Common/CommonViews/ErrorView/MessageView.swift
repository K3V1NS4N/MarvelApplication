//
//  MessageView.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 24/10/21.
//

import UIKit

enum ErrorViewProperties: CGFloat {
    case duration = 0.25
}

class MessageView: UIView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleMessage: UILabel!
    @IBOutlet weak var descriptionMessage: UILabel!
    @IBOutlet weak var button: UIButton!
    var parameters: MessageViewParams?
    var completion: (() -> Void)?
    
    static func configure(with parameters: MessageViewParams) -> MessageView? {
        if let view = UINib(nibName: String(describing: MessageView.self), bundle: Bundle(for: self)).instantiate(withOwner: self, options: nil).first as? MessageView {
            view.parameters = parameters
            view.setupUI()
            return view
        } else { return nil}
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI() {
        self.completion = parameters?.completion
        self.titleMessage.text = parameters?.title
        self.descriptionMessage.text = parameters?.description
        self.icon.image = parameters?.icon
        if let buttonTitle = parameters?.buttonTitle {
            self.button.setTitle(buttonTitle, for: .normal)
        } else {
            self.button.isHidden = true
        }
        
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        guard let completion = completion else {return}
        removeFromSuperview()
        completion()
    }
    
}

open class MessageViewManager {

    public static func showView(from view: UIView, params: MessageViewParams) {
        guard let emptyView = MessageView.configure(with: params) else { return }
        emptyView.frame.size = view.frame.size
        
        UIView.animate(withDuration: TimeInterval(ErrorViewProperties.duration.rawValue)) {
            view.insertSubview(emptyView, at: 0)
        }
    }
}

public struct MessageViewParams {
    public let title: String?
    public let description: String?
    public let buttonTitle: String?
    public let icon: UIImage?
    public let completion: (() -> Void)?
    
    public init(title: String?,
                message: String?,
                buttonTitle: String?,
                icon: UIImage? = .serverErrorIcon,
                completion:(() -> Void)? = nil) {
        self.title = title
        self.description = message
        self.buttonTitle = buttonTitle
        self.icon = icon
        self.completion = completion
        
    }
}
    
